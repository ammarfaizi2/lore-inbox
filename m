Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136617AbREAOJi>; Tue, 1 May 2001 10:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136618AbREAOJa>; Tue, 1 May 2001 10:09:30 -0400
Received: from mnh-1-15.mv.com ([207.22.10.47]:46085 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S136617AbREAOJO>;
	Tue, 1 May 2001 10:09:14 -0400
Message-Id: <200105011522.KAA01925@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Debuggers, KDB or KGDB? 
In-Reply-To: Your message of "Tue, 01 May 2001 11:37:58 +0200."
             <20010501113758.D3305@nightmaster.csn.tu-chemnitz.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 May 2001 10:22:14 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ingo.oeser@informatik.tu-chemnitz.de said:
> Basically you could add support for ALL generic subsystems, that
> support dummy hardware, like SCSI and ISDN for example.

> Is that planned or do I suggest sth. stupid here? ;-) 

Neither.  I know squat about hardware, so I had no idea that SCSI and ISDN 
would be easy to do from UML.

If the SCSI and ISDN people want to produce appropriate UML drivers, I take 
patches :-)

				Jeff


