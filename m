Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131801AbRACAqD>; Tue, 2 Jan 2001 19:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132015AbRACApx>; Tue, 2 Jan 2001 19:45:53 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:4875
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131647AbRACApl>; Tue, 2 Jan 2001 19:45:41 -0500
Date: Tue, 2 Jan 2001 16:15:02 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Rob Landley <landley@flash.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: CPRM copy protection for ATA drives
In-Reply-To: <3A5269DF.588D2C3F@flash.net>
Message-ID: <Pine.LNX.4.10.10101021609140.26680-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I will explain later...

However each key is to broadcasts its identity for the authorized
host/application.  This every license that uses CPRM is trackable.  Since
the method is exotic enough and you can only get the matrix pillars from
the LC4 people, crack will be tough.  There is a 1Meg hidden CPRM space
for key tracking and other services that are unknown.

How it works is still a fuzzy thought, even for the LC4 people.

I have to kill this timeout bug or people will scream bloody murder.

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
