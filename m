Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135984AbRD0G5U>; Fri, 27 Apr 2001 02:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135985AbRD0G5K>; Fri, 27 Apr 2001 02:57:10 -0400
Received: from mail.kdt.de ([195.8.224.4]:4361 "EHLO mail.kdt.de")
	by vger.kernel.org with ESMTP id <S135984AbRD0G4x>;
	Fri, 27 Apr 2001 02:56:53 -0400
Mail-Copies-To: never
To: Sebastien LOISEL <loisel@scylla.math.mcgill.ca>
Cc: linux-kernel@vger.kernel.org, loisel@math.mcgill.ca
Subject: Re: FPU and exceptions
In-Reply-To: <Pine.SGI.3.96.1010426222127.1239514C-100000@scylla.math.mcgill.ca>
From: Andreas Jaeger <aj@suse.de>
Date: 27 Apr 2001 08:52:02 +0200
In-Reply-To: <Pine.SGI.3.96.1010426222127.1239514C-100000@scylla.math.mcgill.ca> (Sebastien LOISEL's message of "Thu, 26 Apr 2001 22:50:53 -0400 (EDT)")
Message-ID: <u8ae527s31.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Send me a small program (10s of lines) that shows the problem.
Installing a signal handler on SIGFPE should do the right thing.

Btw. I do think this is off-topic to linux-kernel,

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
