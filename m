Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265377AbSKEXyC>; Tue, 5 Nov 2002 18:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265378AbSKEXyB>; Tue, 5 Nov 2002 18:54:01 -0500
Received: from maynard.mail.mindspring.net ([207.69.200.243]:25611 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S265377AbSKEXx3>; Tue, 5 Nov 2002 18:53:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Mike Diehl <mdiehl@dominion.dyndns.org>
To: Andres Salomon <dilinger@voxel.net>
Subject: Re: [Evms-announce] EVMS announcement
Date: Tue, 5 Nov 2002 16:29:58 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <02110516191004.07074@boiler> <20021105214012.C2B4651CF@dominion.dyndns.org> <20021105234058.GA28941@chunk.voxel.net>
In-Reply-To: <20021105234058.GA28941@chunk.voxel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021105220947.5AA0551CF@dominion.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 November 2002 06:40 pm, Andres Salomon wrote:
     > Note the difference between LVM (the tools, the on-disk format, etc)
     > and device-mapper (simply a generic interface in the kernel).  I
     > suspect the disasterous LVM experiences you've had were either with
     > LVM1 (which did not use device-mapper), or with some aspect of LVM2's
     > userspace stuff (which, I have yet to hear of any major problems with,
     > other than important features like pvmove not yet being implemented). 
     > There's no reason why EVMS would need to emulate similar behavior.
 
I'm certainly willing to grant that things may have improved since the last 
time I used LVM.  I hope they have.  

It's like the first time you taste sour milk.  You just never forget the 
taste it leaves in your mouth.  LVM tastes the same to me, though it may be 
completely stable/viable now.  <rant off>

-- 
Mike Diehl
PGP Encrypted E-mail preferred.
Public Key via: http://dominion.dyndns.org/~mdiehl/mdiehl.asc

