Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVDMUgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVDMUgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 16:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVDMUgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 16:36:43 -0400
Received: from hagen.doit.wisc.edu ([144.92.197.163]:34512 "EHLO
	smtp7.wiscmail.wisc.edu") by vger.kernel.org with ESMTP
	id S261173AbVDMUgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 16:36:40 -0400
Date: Wed, 13 Apr 2005 20:36:14 +0000
From: John Lenz <lenz@cs.wisc.edu>
Subject: Re: [Crosspost] GNU/Linux userland?
In-reply-to: <425D75AF.7080802@gmx.de>
To: Oliver Korpilla <Oliver.Korpilla@gmx.de>
Cc: debian-kernel@lists.debian.org, debian-toolchain@lists.debian.org,
       linux-gcc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <1113424574l.5708l.0l@hydra>
MIME-version: 1.0
X-Mailer: Balsa 2.3.0
Content-type: text/plain; Format=Flowed; DelSp=Yes; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Spam-Report: AuthenticatedSender=yes, SenderIP=146.151.44.157
X-Spam-PmxInfo: Server=avs-8, Version=4.7.1.128075, Antispam-Engine: 2.0.3.1,
 Antispam-Data: 2005.4.13.11, SenderIP=146.151.44.157
References: <425D75AF.7080802@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13/05 14:40:31, Oliver Korpilla wrote:
> Hello!
> 
> I wondered if there is a project or setup that does allow me to build a  
> GNU/Linux userland including kernel, build environment, basic tools with  
> a single script just as you can in NetBSD (build.sh) or FreeBSD (make  
> world).
> 

You might also look at www.openembedded.org  It has support for cross  
compiling, and with one command can build an entire userland.  Not sure if  
it is exactly a fit for what you want to do, but it seems very close.

John

