Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbTB0LdR>; Thu, 27 Feb 2003 06:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbTB0LdR>; Thu, 27 Feb 2003 06:33:17 -0500
Received: from cal003100.student.utwente.nl ([130.89.160.36]:38893 "EHLO
	margo.student.utwente.nl") by vger.kernel.org with ESMTP
	id <S264654AbTB0LdR>; Thu, 27 Feb 2003 06:33:17 -0500
Date: Thu, 27 Feb 2003 12:43:35 +0100
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre5
Message-ID: <20030227114335.GA4729@margo.student.utwente.nl>
Mail-Followup-To: simon, lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva> <3E5DDCE7.2040100@linux.org.hk> <20030227101912.GA4006@margo.student.utwente.nl> <1046342924.27186.249.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046342924.27186.249.camel@zion.wanadoo.fr>
User-Agent: Mutt/1.4i
From: Simon Oosthoek <simon@margo.student.utwente.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2003 at 11:48:44AM +0100, Benjamin Herrenschmidt wrote:
> On Thu, 2003-02-27 at 11:19, Simon Oosthoek wrote:
> 
> > here's a patch that should work to fix this.
> 
> I think the proper fix for now is to bring back all of
> ieee1394 from pre4 to pre5, it was an incorrect merge
> that reverted part of it.

where do you think I got the patch from ;-)
I diffed pre5 with pre4(-ac4) to get this one...

I'm sure a proper fix is forthcoming by someone more knowledgable than me, I
just posted this to help people get through a compile.

Cheers

Simon
