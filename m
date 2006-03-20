Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWCTLnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWCTLnX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 06:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWCTLnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 06:43:23 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12238 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750761AbWCTLnW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 06:43:22 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Benjamin Bach <benjamin@overtag.dk>
Subject: Re: Idea: Automatic binary driver compiling system
Date: Mon, 20 Mar 2006 13:43:10 +0200
User-Agent: KMail/1.8.2
Cc: Bob Copeland <me@bobcopeland.com>, linux-kernel@vger.kernel.org
References: <441AF93C.6040407@overtag.dk> <b6c5339f0603190719u6e52ba3cwda15509de3ed947e@mail.gmail.com> <441D82D8.7050106@overtag.dk>
In-Reply-To: <441D82D8.7050106@overtag.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603201343.10416.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 March 2006 18:12, Benjamin Bach wrote:
> Bob Copeland wrote:
> >> Anyways, I'm very happy with the combination of intelligence and
> >> idealism on this list, and suddenly I feel more attracted to writing a
> >> driver instead. For my Rio Karma mp3 player. It's a USB thing.. should
> >> be do-able in 3 months even though I've never written a driver.
> >>
> >>     
> >
> > I've already done this and it is in 2.6.16.  There's still some work
> > to be done on the filesystem; check out
> > http://linux-karma.sourceforge.net to help out.
> >
> >   
> Yeah, I immediately found out =) Some very good explanation on your site 
> (http://bobcopeland.com/karma/). I see that you've implemented most of 
> the work, and I can't really figure out any isolated development 
> suitable for a school project. But please, if you have an idea, say so.
> 
> Otherwise I'll probably dig up something. Just needs to be a small 
> kernel-whatever project.
> 
> Is there someone maintaining a list of non-implemented ideas for kernel 
> features/drivers?

Wireless stack and drivers.

http://bcm43xx.berlios.de/
http://195.66.192.167/linux/acx_patches/current_sm/README

(you will also have to checkout wireless-git tree, above README
explains how to do it)
--
vda
