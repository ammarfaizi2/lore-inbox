Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262019AbRENAni>; Sun, 13 May 2001 20:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262021AbRENAnS>; Sun, 13 May 2001 20:43:18 -0400
Received: from baltazar.tecnoera.com ([200.29.128.1]:64517 "EHLO
	baltazar.tecnoera.com") by vger.kernel.org with ESMTP
	id <S262019AbRENAnQ>; Sun, 13 May 2001 20:43:16 -0400
Date: Sun, 13 May 2001 20:41:54 -0400 (CLT)
From: Juan Pablo Abuyeres <jpabuyer@tecnoera.com>
To: <linux-kernel@vger.kernel.org>
Subject: Adaptec RAID SCSI 2100S
Message-ID: <Pine.LNX.4.33.0105132017430.27901-100000@baltazar.tecnoera.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I'm trying to make this card work under 2.4.4, but I couldn't find a patch
anywhere to get it working under 2.4.x nor on 2.2.x. I tried with the I2O
kernel support, but it didn't work, it only reported errors after a pretty
long waiting :)

The CDROM the card comes with brings a precompiled module (dpt_i2o) which
works fine (only?) with 2.2.14.

Adaptec web site says next to nothing about current linux drivers for this
card. I don't understand why they don't just provide a patch against
current 2.2.x and 2.4.x ...

The best I've found is http://people.redhat.com/tcallawa/dpt/, where
they provide a rpm packaged 2.2.19 kernel already with support for adaptec
2100S, and works :-) ... (where did they get the driver??? mistery...)

So, is it possible to make it work under 2.4.4? :-)

ps: has anyone the patch againt 2.2.x? (it would be nice to have the
patch, although I already have 2.2.19 with support)


Thanks.

