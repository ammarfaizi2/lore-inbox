Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317842AbSGZQmv>; Fri, 26 Jul 2002 12:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317845AbSGZQmv>; Fri, 26 Jul 2002 12:42:51 -0400
Received: from mail.cert.uni-stuttgart.de ([129.69.16.17]:10125 "EHLO
	Mail.CERT.Uni-Stuttgart.DE") by vger.kernel.org with ESMTP
	id <S317842AbSGZQmu>; Fri, 26 Jul 2002 12:42:50 -0400
To: martin@dalecki.de
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/9] 2.5.6 lm_sensors
References: <3D381CD1.6A0B9909@bellsouth.net>
	<1027130877.14314.6.camel@irongate.swansea.linux.org.uk>
	<20020726104640.GD279@elf.ucw.cz>
	<1027694678.13429.40.camel@irongate.swansea.linux.org.uk>
	<3D414ECD.3050004@evision.ag>
Mail-Followup-To: martin@dalecki.de, Alan Cox <alan@lxorguk.ukuu.org.uk>,
 Linux Kernel List <linux-kernel@vger.kernel.org>
From: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Date: Fri, 26 Jul 2002 18:46:06 +0200
In-Reply-To: <3D414ECD.3050004@evision.ag> (Marcin Dalecki's message of
 "Fri, 26 Jul 2002 15:29:49 +0200")
Message-ID: <871y9qxws1.fsf@CERT.Uni-Stuttgart.DE>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Dalecki <dalecki@evision.ag> writes:

>> Given an afternoon someone competent can easily write a worm that
>> destroys every scsi hard disk, almost every PC bios, your IDE firmware,
>> some laptop batteries some USB devices and far more.
>> The "you cant break the computer" thing is simply not true for almost
>> any PC class device. I wouldn't pick on IBM here.
>
> And it would be after all a bit hard to get an exponential propagation
> curve, becouse the incubator is killing himself in this case :-).

In practice, you don't see exponential growth, but logistic growth, as
it becomes more and more difficult to spot new victims.  So you just
have to wait with distruction until the rate at which an individual
host can infect targets drops below a certain threshold or something
like that.

-- 
Florian Weimer 	                  Weimer@CERT.Uni-Stuttgart.DE
University of Stuttgart           http://CERT.Uni-Stuttgart.DE/people/fw/
RUS-CERT                          fax +49-711-685-5898
