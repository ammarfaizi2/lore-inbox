Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUHVLhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUHVLhW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 07:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266657AbUHVLhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 07:37:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:65500 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266650AbUHVLhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 07:37:21 -0400
X-Authenticated: #1725425
Date: Sun, 22 Aug 2004 13:38:05 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: "James M." <dart@windeath.2y.net>
Cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: Obvious one-liner - Use 3DNOW on MK8
Message-Id: <20040822133805.0b6d858c.Ballarin.Marc@gmx.de>
In-Reply-To: <4128349B.7050304@windeath.2y.net>
References: <2vOfA-7Vg-7@gated-at.bofh.it>
	<m34qmwx8nv.fsf@averell.firstfloor.org>
	<4128349B.7050304@windeath.2y.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004 00:52:27 -0500
"James M." <dart@windeath.2y.net> wrote:

> Then perhaps the code should be removed or at least explain in the help 
> why it can't be selected...do you have a preference?
> 
> Does having this disabled confuse apps like Mplayer who detect the cpu 
> and expect it to be there? I'm guessing the kernel handles it correctly 
> but I'm just curious.
> 

The option only affects in-kernel usage of 3dnow.  It has absolutely no
effect on userspace apps.

mfg

