Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316492AbSFLIjd>; Wed, 12 Jun 2002 04:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317348AbSFLIjc>; Wed, 12 Jun 2002 04:39:32 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:52864 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S316492AbSFLIjb>; Wed, 12 Jun 2002 04:39:31 -0400
Date: Wed, 12 Jun 2002 10:45:32 +0200
Organization: Pleyades
To: aeriksson@fastmail.fm, raul@pleyades.net
Subject: Re: QoS on incoming data
Cc: linux-kernel@vger.kernel.org
Message-ID: <3D070A2C.mail2E4114UKH@viadomus.com>
In-Reply-To: <20020611205706.E3A8B470D@tippex.localdomain>
User-Agent: nail 9.29 12/10/01
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Anders :)

>You said way back that it was only wget that did hog the andbith,
>right?

    Well, not exactly. Let's say that wget seems more 'aggresive',
but really the one who gets all the speed is the *first* downloading
program started, although some of them seems to be more friendly than
others. Wget is a corner case. Lukemftp is less aggresive.

    I've already considered the tcp windows issue, but is not the
case (IMHO). I think that's more probable the option regarding ISP
large queues.

    Thanks for your answer and interest :))
    Raúl
