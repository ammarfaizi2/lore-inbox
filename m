Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267234AbRGYTlE>; Wed, 25 Jul 2001 15:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267241AbRGYTkz>; Wed, 25 Jul 2001 15:40:55 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:59919 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S267234AbRGYTkq>;
	Wed, 25 Jul 2001 15:40:46 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107251940.XAA12699@ms2.inr.ac.ru>
Subject: Re: ifconfig and SIOCSIFADDR
To: Andries.Brouwer@cwi.nl
Date: Wed, 25 Jul 2001 23:40:42 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org, net-tools@lina.inka.de, philb@gnu.org
In-Reply-To: <200107251923.TAA21053@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl" at Jul 25, 1 07:23:55 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> Yes. It didn't in 2.0.

Soooory, it did. This behavior is copied from there. :-)



> Yes. I liked such logic thirty years ago. That is Unix.

:-) Seems, thirty years ago there were not only Internet but Unix too.

BTW I did not hear about any kind of Unix, which forgets
to set a valid mask on newly selected address.

ifconfig eth0 193.233.7.65 works nicely everywhere.
Only on 4.2BSD it creates bad "zero" broadcast.

Alexey

