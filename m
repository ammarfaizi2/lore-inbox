Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262112AbSJIWJo>; Wed, 9 Oct 2002 18:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262114AbSJIWJo>; Wed, 9 Oct 2002 18:09:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2740 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262112AbSJIWJo>;
	Wed, 9 Oct 2002 18:09:44 -0400
Date: Wed, 09 Oct 2002 15:08:18 -0700 (PDT)
Message-Id: <20021009.150818.102229501.davem@redhat.com>
To: vividh@ipinfusion.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Interface address change netlink socket
 problem.(Patch attached)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DA4A3A3.2090408@ipinfusion.com>
References: <3DA4A3A3.2090408@ipinfusion.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can you explain how not initializing some fields of the 'ifa'
prevents the extra netlink messages?  I don't understand how
your patch works.
