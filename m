Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263428AbTC2OrT>; Sat, 29 Mar 2003 09:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263429AbTC2OrT>; Sat, 29 Mar 2003 09:47:19 -0500
Received: from [81.2.110.254] ([81.2.110.254]:32755 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S263428AbTC2OrS>;
	Sat, 29 Mar 2003 09:47:18 -0500
Subject: Re: Issues in 2.5.65-ac4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "S.Gopi" <sekargopi@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1048920381.2383.22.camel@Agni>
References: <1048920381.2383.22.camel@Agni>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048950005.6847.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 29 Mar 2003 15:00:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-29 at 06:46, S.Gopi wrote:
> problem on /proc/cpuinfo. cpuinfo doesnt showup speed in MHz. It shows
> it as 0.00. and it shows different bogomips too.

Bogomips is an approximation anyway. The CPU speed one is a bug in the 
-ac kernel tree. Steven Cole pinned down the actual problem.


