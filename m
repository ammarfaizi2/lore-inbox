Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317188AbSFKRCB>; Tue, 11 Jun 2002 13:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSFKRCA>; Tue, 11 Jun 2002 13:02:00 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:40832 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S317188AbSFKRB7>; Tue, 11 Jun 2002 13:01:59 -0400
Date: Tue, 11 Jun 2002 19:07:59 +0200
Organization: Pleyades
To: pochini@shiny.it, raul@pleyades.net
Subject: Re: bandwidth 'depredation'
Cc: linux-kernel@vger.kernel.org
Message-ID: <3D062E6F.mail1QU2YH0M4@viadomus.com>
In-Reply-To: <XFMail.20020611151754.pochini@shiny.it>
User-Agent: nail 9.29 12/10/01
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Giuliano :)

>>     IMHO, the IP layer (well, in this case the TCP layer) should
>> distribute the bandwidth (although I don't know how to do this), and
>> the kernel seems to be not doing it.
>No, IP doesn't balance anything. You have to filter the traffic with
>QoS of traffic shapers to give different "priorities" to packets as
>you like. Wget doesn't "grab" the bandwidth, it's the remote server
>that fills it.

    Now I know it, but I don't understand how shaping the outgoing
traffic will help with my incoming traffic O:)

    Thanks for answering :)

    Raúl
