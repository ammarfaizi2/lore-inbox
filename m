Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262998AbSJGL6i>; Mon, 7 Oct 2002 07:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262999AbSJGL6i>; Mon, 7 Oct 2002 07:58:38 -0400
Received: from mail.cyberus.ca ([216.191.240.111]:35972 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S262998AbSJGL6h>;
	Mon, 7 Oct 2002 07:58:37 -0400
Date: Mon, 7 Oct 2002 07:56:59 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Andre Hedrick <andre@pyxtechnologies.com>
cc: Ben Greear <greearb@candelatech.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>
Subject: Re: Update on e1000 troubles (over-heating!)
In-Reply-To: <Pine.LNX.4.10.10210061700000.23945-100000@master.linux-ide.org>
Message-ID: <Pine.GSO.4.30.0210070753400.1861-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



It does seem like you need a lot of packets over a period of time
to recreate it. So if what you are trying to do can achieve that,
you should reproduce it. How many connections and sessions can you
support? BTW, does iscsi call for a zero-copy receive?

cheers,
jamal



