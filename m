Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318248AbSIOUY4>; Sun, 15 Sep 2002 16:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318249AbSIOUY4>; Sun, 15 Sep 2002 16:24:56 -0400
Received: from mail.cyberus.ca ([216.191.240.111]:41197 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S318248AbSIOUY4>;
	Sun, 15 Sep 2002 16:24:56 -0400
Date: Sun, 15 Sep 2002 16:22:55 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ben Greear <greearb@candelatech.com>
cc: "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  Enable sending network traffic to local machine over
 external interfaces.
In-Reply-To: <3D842C3C.6000205@candelatech.com>
Message-ID: <Pine.GSO.4.30.0209151616280.22001-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What bad stuff are you smoking lately? Trying to turn linux into a traffic
generator OS? ;-> Havent you been accused of that already?
Actually, this is probably one of the few times i agree with you because i
may have use for this; i dont think the maintainers may. Infact i think
you are just about to be shot.
How about putting ifdefs so that the code only gets activated if
packetgen is active?

cheers,
jamal

