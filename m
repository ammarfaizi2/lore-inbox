Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263118AbTJEOaS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 10:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263119AbTJEOaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 10:30:18 -0400
Received: from filesrv1.system-techniques.com ([199.33.245.55]:21648 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S263118AbTJEOaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 10:30:14 -0400
Date: Sun, 5 Oct 2003 10:30:10 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: "David S. Miller" <davem@redhat.com>
cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: iproute2 not compiling anymore
In-Reply-To: <20031005071152.49c35297.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0310051028230.8777@filesrv1.baby-dragons.com>
References: <Pine.LNX.4.44.0310050940160.27815-100000@logos.cnet>
 <20031005130044.GA8861@pcw.home.local> <20031005071152.49c35297.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello Dave ,

On Sun, 5 Oct 2003, David S. Miller wrote:
> On Sun, 5 Oct 2003 15:00:44 +0200
> Willy TARREAU <willy@w.ods.org> wrote:
> > /usr/src/linux/include/linux/in.h:147: field `gsr_group' has incomplete type
> I'll happily fix this, thanks for reporting this.
> Can you please in the future report such things on the networking
> development list netdev@oss.sgi.com?  Thanks.
	What has happened to linux-net ?
	One more maillist I and others have to watch for exploding
	pieces .  JimL

-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
