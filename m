Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270592AbTGPIzu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 04:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270460AbTGPIzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 04:55:50 -0400
Received: from cm61.gamma179.maxonline.com.sg ([202.156.179.61]:15488 "EHLO
	hera.eugeneteo.net") by vger.kernel.org with ESMTP id S270592AbTGPIzs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 04:55:48 -0400
Date: Wed, 16 Jul 2003 17:10:38 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: linux-kernel@vger.kernel.org
Subject: Re: modules problems with 2.6.0
Message-ID: <20030716091038.GA2355@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <3F147B8F.5000103@mail.usfq.edu.ec> <20030716084314.GB31074@lisa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716084314.GB31074@lisa>
X-Operating-System: Linux 2.6.0-test1-mm1
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<quote sender="Marc Schiffbauer">
> * Fernando Sanchez schrieb am 16.07.03 um 00:09 Uhr:
> > Hi,
> > 
> > I've been trying to get 2.6.0 to work, I've enabled modules support, but 
> > I get this error on my logs:
> > 
> > Jul 15 15:38:36 Darakemba kernel: No module symbols loaded - kernel 
> > modules not enabled.
> > 
> > Is there any thing like a new modutils that should be used with 2.6.x 
> > family?
> > 
> > The kernel does boot, but not having any modules I can't do much, and 
> > also, I never get to really see the messages on screen, on logs I have 
> > this line:
> > 
> > Jul 15 15:38:36 Darakemba kernel: Video mode to be used for restore is ffff
> > 
> > What does it mean?
> > 
> > I disabled all the framebuffer things so I can just use vga, on lilo, 
> > vga mode is set to normal, but still can't see anything.
>
> Fernando,
> 
> 
> read http://www.codemonkey.org.uk/post-halloween-2.5.txt
> (but hsving DNS problems from germany right now)

If you are using debian, apt-get install module-init-tools.

-- 
Eugene TEO @ Linux Users Group, Singapore <eugeneteo@lugs.org.sg>
GPG FP: D851 4574 E357 469C D308  A01E 7321 A38A 14A0 DDE5 
main(i){putchar(182623909>>(i-1)*5&31|!!(i<7)<<6)&&main(++i);}

