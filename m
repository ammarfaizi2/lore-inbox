Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315628AbSG1KyG>; Sun, 28 Jul 2002 06:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315629AbSG1KyG>; Sun, 28 Jul 2002 06:54:06 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:2944 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S315628AbSG1KyF>; Sun, 28 Jul 2002 06:54:05 -0400
Date: Sun, 28 Jul 2002 13:04:51 +0200
Organization: Pleyades
To: vherva@niksula.hut.fi, raul@pleyades.net
Subject: Re: About the need of a swap area
Cc: linux-kernel@vger.kernel.org
Message-ID: <3D43CFD3.mailML115DUP@viadomus.com>
References: <3D42907C.mailFS15JQVA@viadomus.com>
 <20020727144228.GQ1548@niksula.cs.hut.fi>
 <3D42C62F.mail5XQ31DIAC@viadomus.com>
 <20020727170124.GR1465@niksula.cs.hut.fi>
In-Reply-To: <20020727170124.GR1465@niksula.cs.hut.fi>
User-Agent: nail 9.31 6/18/02
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Ville :)

>>     Yes, that makes sense, obviously. My question is more: when an
>> inactive page will be swapped out? Only when there is no more RAM
>> left? 
>No, it is smarter than that.

    Well, I supposed it ;) Then I will reduce my swap area size
(since it's mostly unused) and will go with it :)

>> How to configure it?
>Through the tunables in /proc/sys/vm/.

    Ok, thanks :))

    Raúl
