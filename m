Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVCARwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVCARwr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 12:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVCARwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 12:52:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:31632 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262000AbVCARwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 12:52:39 -0500
Date: Tue, 1 Mar 2005 17:52:03 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: linux-fbdev-devel@lists.sourceforge.net
cc: Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@stusta.de>,
       adaplas@pol.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] Re: RFC: disallow modular framebuffers
In-Reply-To: <9e47339105022822079eb6f86@mail.gmail.com>
Message-ID: <Pine.LNX.4.56.0503011751140.1795@pentafluge.infradead.org>
References: <20050301024118.GF4021@stusta.de> <4223E59D.3060902@pobox.com>
 <9e47339105022822079eb6f86@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't think the framebuffer codebase has received the same level of
> inspection that a lot of the other kernel code has. This is probably
> because all X86 users can currently avoid loading them due to VGA
> compatibility.

Actaully it has recieved inspection but we don't have the man power to 
clean up the system. It will always lag because of this :-( 
