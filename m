Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288535AbSADMOY>; Fri, 4 Jan 2002 07:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288601AbSADMOO>; Fri, 4 Jan 2002 07:14:14 -0500
Received: from NILE.GNAT.COM ([205.232.38.5]:55544 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S288535AbSADMOF>;
	Fri, 4 Jan 2002 07:14:05 -0500
From: dewar@gnat.com
To: dewar@gnat.com, fw@deneb.enyo.de
Subject: Re: [PATCH] C undefined behavior fix
Cc: Dautrevaux@microprocess.com, Franz.Sirl-kernel@lauterbach.com,
        benh@kernel.crashing.org, gcc@gcc.gnu.org, jtv@xs4all.nl,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
        minyard@acm.org, paulus@samba.org, rth@redhat.com,
        trini@kernel.crashing.org, velco@fadata.bg
Message-Id: <20020104121403.D7262F3123@nile.gnat.com>
Date: Fri,  4 Jan 2002 07:14:03 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<We have seen much trouble in this area before, but I doubt we can
avoid all of them by proper documentation.  Quite a few people seem to
write some C code, check that it works, look at the generated machine
code, and if it seems to be correct, the C code is considered to be
correct.
>>

We can't avoid people writing wrong code, but we can avoid debate as to
whether the code is right or wrong :-)
