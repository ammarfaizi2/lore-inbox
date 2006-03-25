Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWCYO2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWCYO2Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 09:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWCYO2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 09:28:25 -0500
Received: from ns2.suse.de ([195.135.220.15]:38609 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751243AbWCYO2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 09:28:25 -0500
From: Andi Kleen <ak@suse.de>
To: sam@ravnborg.org
Subject: Re: ccache complains in latest git about -p
Date: Sat, 25 Mar 2006 15:28:20 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200603251521.32217.ak@suse.de>
In-Reply-To: <200603251521.32217.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603251528.20299.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 March 2006 15:21, Andi Kleen wrote:
> 
> ccache complains for me on x86-64 now:
> 
> > make CC=ccache 

Sorry ignore email. Obviously was a typo on my side. With CC="ccache cc" 
it works as expected.

-Andi
