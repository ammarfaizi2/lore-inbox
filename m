Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265173AbSJWTgx>; Wed, 23 Oct 2002 15:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265175AbSJWTgx>; Wed, 23 Oct 2002 15:36:53 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:56302 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S265173AbSJWTgw>; Wed, 23 Oct 2002 15:36:52 -0400
Message-Id: <5.1.0.14.2.20021023124123.09b83e00@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 23 Oct 2002 12:42:45 -0700
To: jamal <hadi@cyberus.ca>, Tim Hockin <thockin@hockin.org>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: rtnetlink interface state monitoring problems.
Cc: David Woodhouse <dwmw2@infradead.org>, <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>
In-Reply-To: <Pine.GSO.4.30.0210222313050.24323-100000@shell.cyberus.ca>
References: <200210230144.g9N1iDx11822@www.hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>netlink is a messaging system; so what i am thinking is creating
>a event notifier for other devices other than network devices.
>Something other non-network devices could use (eg bluetooth).
What kind of events are we taking about ?

Max

