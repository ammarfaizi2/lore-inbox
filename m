Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266100AbTBKVD5>; Tue, 11 Feb 2003 16:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbTBKVD5>; Tue, 11 Feb 2003 16:03:57 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:3456
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266100AbTBKVD4>; Tue, 11 Feb 2003 16:03:56 -0500
Subject: Re: 2.4.21-pre4-ac3 hangs at reboot
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: walt <wa1ter@hotmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E47E257.3000904@hotmail.com>
References: <3E47E257.3000904@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044913493.2077.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 10 Feb 2003 21:44:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-10 at 17:33, walt wrote:
> Hi Alan,
> 
> Actually this problem started with ac2.  All seems to work well until I
> reboot the machine with 'shutdown' or 'reboot' or 'ctl-alt-del'.
> 
> The machine shuts down properly to the point where all filesystems
> are remounted readonly, which is the point where I normally see an
> immediate reboot.  Starting with pre4-ac2 I just get an indefinite
> hang instead of the reboot.

I know about it, I've not yet had time to track it down

