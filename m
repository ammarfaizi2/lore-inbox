Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267122AbTBDGDr>; Tue, 4 Feb 2003 01:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267124AbTBDGDr>; Tue, 4 Feb 2003 01:03:47 -0500
Received: from rth.ninka.net ([216.101.162.244]:23506 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267122AbTBDGDq>;
	Tue, 4 Feb 2003 01:03:46 -0500
Subject: Re: 2.4.20 Broken Path MTU Discovery?
From: "David S. Miller" <davem@redhat.com>
To: Carlos Velasco <carlosev@newipnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200302031545120119.2E88A90C@192.168.128.16>
References: <200302021958160177.2A4B5622@192.168.128.16.suse.lists.linux.kernel>
	<p738ywyqk8w.fsf@oldwotan.suse.de>
	<1044279732.20152.6.camel@irongate.swansea.linux.org.uk> 
	<200302031545120119.2E88A90C@192.168.128.16>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Feb 2003 22:54:52 -0800
Message-Id: <1044341692.25877.2.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 06:45, Carlos Velasco wrote:
> Also, it is not so easy to send spoofed icmps as the icmp must contain the original packet with high len that caused the icmp.

Anyone sitting between the two machines may do the
spoofing.

Do you trust every single router between your system
and the machine you are accessing out on the web?

