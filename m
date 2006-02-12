Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWBLEpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWBLEpN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 23:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWBLEpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 23:45:13 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:53941 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932202AbWBLEpL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 23:45:11 -0500
To: Adrian Bunk <bunk@stusta.de>
cc: "V. Ananda Krishnan" <mansarov@us.ibm.com>, Scott_Kilau@digi.com,
       linux-kernel@vger.kernel.org, wendyx@us.ibm.com, wenxiong@us.ibm.com
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [2.6 patch] remove the no longer valid contact information for Wendy Xiong 
In-reply-to: Your message of Sat, 11 Feb 2006 23:42:45 +0100.
             <20060211224245.GG30922@stusta.de> 
Date: Sat, 11 Feb 2006 20:44:32 -0800
Message-Id: <E1F8968-0001KD-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Feb 2006 23:42:45 +0100, Adrian Bunk wrote:
> On Sat, Feb 11, 2006 at 03:55:24PM -0600, V. Ananda Krishnan wrote:
> > Adrian Bunk wrote:
> > >The email address wendyx@us.ltcfwd.linux.ibm.com of Wendy Xiong present 
> > >in three files under drivers/serial/jsm/ is bouncing.
> > >
> > >Is there a new address, or should the old one simply be removed?
> > >
> > Thanks Adrian. Please remove Wendy's name for now.
> >...
> 
> Patch below.
> 
> > Regards,
> > V. Ananda Krishnan
> 
> cu
> Adrian
> 
> 
> <--  snip  -->
> 
> 
> This patch removes the no longer valid contact information for 
> Wendy Xiong.

Adrian,

FYI - Wen Xiong is aka wendyx@us.ibm.com or wenxiong@us.ibm.com.

The us.ltcfwd.linux.ibm.com is an evil address which escaped from
the firewall at one point in time.

I'll let Wen decide whether an updated  MAINTAINERS entry is worthwhile.

gerrit
