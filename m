Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWD3Iud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWD3Iud (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 04:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWD3Iuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 04:50:32 -0400
Received: from cantor.suse.de ([195.135.220.2]:13974 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751054AbWD3Iuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 04:50:32 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss]  Re: [RFC] make PC Speaker driver work on x86-64
Date: Sun, 30 Apr 2006 10:50:22 +0200
User-Agent: KMail/1.9.1
Cc: Matthieu CASTET <castet.matthieu@free.fr>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <200604291830.k3TIUA23009336@harpo.it.uu.se> <pan.2006.04.29.21.00.09.180837@free.fr>
In-Reply-To: <pan.2006.04.29.21.00.09.180837@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200604301050.22984.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 April 2006 23:00, Matthieu CASTET wrote:
> Hi,
> 
> Le Sat, 29 Apr 2006 20:30:10 +0200, Mikael Pettersson a écrit :
> 
> 
> > 
> > Is there a better way to do this? ACPI?
> > 
> Yes, I believe using PNP layer (that use ACPI with pnpacpi) with PNP0800
> will be cleaner.

Please do a patch then.

-Andi
