Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285632AbRLWKIp>; Sun, 23 Dec 2001 05:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285636AbRLWKI0>; Sun, 23 Dec 2001 05:08:26 -0500
Received: from ssh.elis.rug.ac.be ([157.193.67.1]:29617 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S285632AbRLWKIQ>; Sun, 23 Dec 2001 05:08:16 -0500
Date: Sun, 23 Dec 2001 11:07:55 +0100 (CET)
From: Frank Cornelis <fcorneli@elis.rug.ac.be>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: earlyclobber
In-Reply-To: <01122223531400.01860@manta>
Message-ID: <Pine.LNX.4.33.0112231103130.30291-100000@trappist.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I think that in the file include/asm-i386/uaccess.h in some macro's the
> > ecx register should be marked as an "earlyclobber" operand since it is
> > one. Patch follows.
> 
> How did you notice it?

By simply reading through the source code. It's so much more exciting than 
reading a book and it gets me to sleep in no time :)

Frank.

