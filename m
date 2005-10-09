Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVJIQtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVJIQtF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 12:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVJIQtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 12:49:05 -0400
Received: from newmail.linux4media.de ([193.201.54.81]:19142 "EHLO l4m.mine.nu")
	by vger.kernel.org with ESMTP id S932121AbVJIQtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 12:49:04 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: Modular i810fb broken, partial fix
Date: Sun, 9 Oct 2005 18:48:19 +0200
User-Agent: KMail/1.8.91
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, linux-kernel@vger.kernel.org
References: <200510071547.14616.bero@arklinux.org> <4347C39F.2020703@pol.net> <4347E611.9040705@roarinelk.homelinux.net>
In-Reply-To: <4347E611.9040705@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510091848.19345.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 8. October 2005 17:30, Manuel Lauss wrote:
> for reference:
> modprobe i810fb mode_option=1024x768-8@60 hsync1=40 hsync2=60 vsync1=50
> vsync2=70 vram=4

Can you try with 1024x768-16@60? That's what we're using in the installer (and 
what people reported to gable the display).

Thanks
bero
