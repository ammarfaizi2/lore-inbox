Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSJMHXA>; Sun, 13 Oct 2002 03:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261449AbSJMHXA>; Sun, 13 Oct 2002 03:23:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45196 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261448AbSJMHW7>;
	Sun, 13 Oct 2002 03:22:59 -0400
Date: Sun, 13 Oct 2002 00:21:14 -0700 (PDT)
Message-Id: <20021013.002114.110496217.davem@redhat.com>
To: ak@suse.de
Cc: wagnerjd@prodigy.net, robm@fastmail.fm, hahn@physics.mcmaster.ca,
       linux-kernel@vger.kernel.org, jhoward@fastmail.fm
Subject: Re: Strange load spikes on 2.4.19 kernel
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <p73elaupzrj.fsf@oldwotan.suse.de>
References: <000001c27286$6ab6bc60$7443f4d1@joe.suse.lists.linux.kernel>
	<20021013.000127.43007739.davem@redhat.com.suse.lists.linux.kernel>
	<p73elaupzrj.fsf@oldwotan.suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: 13 Oct 2002 09:24:32 +0200
   
   It depends on your file system.
...   
   Still in 2.4 the VFS takes the big kernel lock unnecessarily
...
   That's fixed in 2.5.

All true.

