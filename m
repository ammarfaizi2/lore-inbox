Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262992AbSJGLzP>; Mon, 7 Oct 2002 07:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262993AbSJGLzP>; Mon, 7 Oct 2002 07:55:15 -0400
Received: from mail.cyberus.ca ([216.191.240.111]:57986 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S262992AbSJGLzO>;
	Mon, 7 Oct 2002 07:55:14 -0400
Date: Mon, 7 Oct 2002 07:53:26 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ben Greear <greearb@candelatech.com>
cc: Andre Hedrick <andre@pyxtechnologies.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>
Subject: Re: Update on e1000 troubles (over-heating!)
In-Reply-To: <3DA103A2.1060901@candelatech.com>
Message-ID: <Pine.GSO.4.30.0210070749430.1861-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Oct 2002, Ben Greear wrote:

> I can reproduce my crash using mtu sized pkts running only 50Mbps
> send + receive on 2 nics.  It took over-night to do it though.  Running
> as hard as I can with MTU packets will crash it as well, and much
>quicker.
>

So is there a correlation with packet count then?


> Interestingly enough, the tg3 NIC (netgear 302t), registered 57 deg C between
> the fins of it's heat sink in the 32-bit slots.  Makes me wonder if my PCI bus
> is running too hot :P

Does the problem happen with the tg3?

cheers,
jamal


