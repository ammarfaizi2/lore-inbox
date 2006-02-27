Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWB0WjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWB0WjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWB0Wif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:38:35 -0500
Received: from cantor2.suse.de ([195.135.220.15]:2949 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964861AbWB0WiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:38:13 -0500
From: Andi Kleen <ak@suse.de>
To: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch 5/7]  synchronous block I/O delays
Date: Mon, 27 Feb 2006 23:20:51 +0100
User-Agent: KMail/1.9.1
Cc: Arjan van de Ven <arjan@infradead.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
References: <1141026996.5785.38.camel@elinux04.optonline.net> <p73fym428cf.fsf@verdi.suse.de> <44037897.4050709@watson.ibm.com>
In-Reply-To: <44037897.4050709@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602272320.52536.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 23:09, Shailabh Nagar wrote:

> Besides the paths we're counting and the one's Arjan listed below, are 
> there others
> you had in mind ?

I would like to see all reads including metadata reads in file systems.

-Andi
