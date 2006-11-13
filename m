Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933166AbWKMXTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933166AbWKMXTu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 18:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933167AbWKMXTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 18:19:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55688 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933160AbWKMXTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 18:19:48 -0500
Date: Mon, 13 Nov 2006 15:15:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Brian King <brking@us.ibm.com>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, jgarzik@pobox.com,
       linux-ide@vger.kernel.org
Subject: Re: 2.6.19-rc5: known regressions with patches
In-Reply-To: <4558F833.4090204@us.ibm.com>
Message-ID: <Pine.LNX.4.64.0611131514190.22714@g5.osdl.org>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
 <20061113221446.GJ22565@stusta.de> <4558F833.4090204@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Nov 2006, Brian King wrote:

> Adrian Bunk wrote:
> > Subject    : libata must be initialized earlier
> > References : http://ozlabs.org/pipermail/linuxppc-dev/2006-November/027945.html
> > Submitter  : Paul Mackerras <paulus@samba.org>
> > Handled-By : Brian King <brking@us.ibm.com>
> > Patch      : http://marc.theaimsgroup.com/?l=linux-ide&m=116169938407596&w=2
> > Status     : patch available
> 
> I just resubmitted this patch a few minutes ago.

I definitely want an ACK on this from Jeff - I'll take a few broken ppc64 
machines any day over the worry that there might be problems elsewhere. 

Jeff? Ack, Nack, or "I'll push it to you through my git tree", please..

		Linus
