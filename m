Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbVJHLCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbVJHLCw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 07:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbVJHLCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 07:02:52 -0400
Received: from newmail.linux4media.de ([193.201.54.81]:32129 "EHLO l4m.mine.nu")
	by vger.kernel.org with ESMTP id S1750993AbVJHLCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 07:02:51 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Modular i810fb broken, partial fix
Date: Sat, 8 Oct 2005 13:02:11 +0200
User-Agent: KMail/1.8.91
Cc: adaplas@users.sourceforge.net, linux-kernel@vger.kernel.org
References: <200510071547.14616.bero@arklinux.org> <4347A1E7.2050201@pol.net>
In-Reply-To: <4347A1E7.2050201@pol.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510081302.12190.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 8. October 2005 12:39, Antonino A. Daplas wrote:
> Did you compile CONFIG_FRAMEBUFFER_CONSOLE statically, or did a modprobe
> fbcon? Does i810fb work if compiled statically?

CONFIG_FRAMEBUFFER_CONSOLE is compiled statically. Can't tell if it works if 
compiled statically because I don't have the hardware -- I'll try to get the 
user who reported this to check though.
