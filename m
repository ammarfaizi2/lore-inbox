Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268421AbTAMXP0>; Mon, 13 Jan 2003 18:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268422AbTAMXP0>; Mon, 13 Jan 2003 18:15:26 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:50644 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S268421AbTAMXPZ>; Mon, 13 Jan 2003 18:15:25 -0500
Message-Id: <5.1.0.14.2.20030113152231.0d4b7370@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 13 Jan 2003 15:23:59 -0800
To: kuznet@ms2.inr.ac.ru, rusty@rustcorp.com.au (Rusty Russell)
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [RFC] Migrating net/sched to new module interface
Cc: kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
In-Reply-To: <200301132232.BAA09527@sex.inr.ac.ru>
References: <20030103051033.1A2AA2C003@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:32 AM 1/14/2003 +0300, kuznet@ms2.inr.ac.ru wrote:
>It is not essential in this particular case,
>but it would be funny to ask it each time when creating a tcp socket.

That's what we're going to do btw. I'm cooking up new patch. 
See "New module refcounting for net_proto_family" thread.

Max

