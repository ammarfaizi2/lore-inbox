Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbULOTr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbULOTr0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 14:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbULOTpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 14:45:32 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:24458
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262467AbULOTom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 14:44:42 -0500
Date: Wed, 15 Dec 2004 11:40:17 -0800
From: "David S. Miller" <davem@davemloft.net>
To: David Jacoby <dj@outpost24.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel IGMP vulnerabilities, PATCH IS BROKEN!
Message-Id: <20041215114017.3a735aa8.davem@davemloft.net>
In-Reply-To: <41C0268B.2030708@outpost24.com>
References: <41BFF931.6030205@outpost24.com>
	<20041215.180839.93043538.yoshfuji@linux-ipv6.org>
	<41C024B0.4010009@outpost24.com>
	<200412151254.37612@WOLK>
	<41C0268B.2030708@outpost24.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004 12:56:59 +0100
David Jacoby <dj@outpost24.com> wrote:

> Well it is, i booted on the old kernel and SSH worked perfect and then 
> on the new kernel with the patch i cant SSH, i dont even
> get an password prompt. I tried to ssh to more than one host aswell, i 
> also removed the key in .known_hosts but it still doesnt work.
> 
> Have you installed the patch?

I'm personally running it everywhere here, and ssh works fine.

There is no way that patch can change SSH behavior, you changed
something else when you updated your kernel.
