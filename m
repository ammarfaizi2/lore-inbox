Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277533AbRJVEFu>; Mon, 22 Oct 2001 00:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277529AbRJVEFa>; Mon, 22 Oct 2001 00:05:30 -0400
Received: from tully.jetstream.net ([207.23.175.2]:35079 "EHLO
	tully.jetstream.net") by vger.kernel.org with ESMTP
	id <S277526AbRJVEFU>; Mon, 22 Oct 2001 00:05:20 -0400
Message-Id: <5.0.2.1.2.20011021150919.00a57a60@mail.jetstream.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sun, 21 Oct 2001 15:14:23 -0700
To: linux-kernel@vger.kernel.org
From: Leo Spalteholz <bspalteh@jetstream.net>
Subject: RE: The new X-Kernel !
In-Reply-To: <000801c15a78$b79a4280$150a10ac@gearboxsoftware.com>
In-Reply-To: <20011021220346.D19390@vega.digitel2002.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>This side thread is funny, everyone here is thinking too much like a
>developer :)
>
>Normal users really don't need to see the startup message spam on boot,
>unless there is an error (at which point it should be able to present
>the error to the user).  Any kind of of progress indicator' s really
>more for feedback that the boot is proceeding ok.  The fact the boot
>sequence isn't even interactive should also be a big hint that it isn't
>really necessary (except for kernel and driver developers).


I agree that for the normal user, plain messages are useless..   I remember 
something in Mandrake (7.0?), what they did is print a green [OK]  after 
every message and a red [ERROR] when something failed..  This was great for 
a quick visual check..   As soon as you see something red scroll past you 
know there's something wrong and you can check it later..
So this should really be left up to the distros..



