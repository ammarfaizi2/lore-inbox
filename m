Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262480AbSKTTH0>; Wed, 20 Nov 2002 14:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262464AbSKTTG4>; Wed, 20 Nov 2002 14:06:56 -0500
Received: from ifup.net ([217.160.130.191]:27555 "HELO sit0.ifup.net")
	by vger.kernel.org with SMTP id <S262480AbSKTTGF>;
	Wed, 20 Nov 2002 14:06:05 -0500
Date: Wed, 20 Nov 2002 20:13:28 +0100
From: Karsten Desler <soohrt@soohrt.org>
To: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org, Ulrich Wiederhold <U.Wiederhold@gmx.net>
Subject: Re: 2.4.20-rc1-ac4 HPT374 doesn't find connected ide drives
Message-ID: <20021120191328.GA24741@soohrt.org>
References: <20021119105955.A23008@pc9391.uni-regensburg.de> <20021119102338.GA24510@sit0.ifup.net> <20021119113300.C23008@pc9391.uni-regensburg.de> <20021119152244.GA26989@sit0.ifup.net> <20021119180317.A2597@pc9391.uni-regensburg.de> <20021119193530.GA915@sit0.ifup.net> <20021120175350.A6312@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20021120175350.A6312@pc9391.uni-regensburg.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> so today I added 4 more drives to my hpt374, tried 2.5.47-ac6 and works 
> flawlessy...

Yep, 2.5.46 and 2.5.47-ac6 work for me too.

> [/dev/hd* device creation]

You're right, thanks - but that's not the problem since the md raid
autodetection happenes before / is mounted.

Anyways, I wondered why I couldn't use hdparm on all the raid devices
but haven't tried to solve the problem :-), thanks.

Bye
 Karsten
