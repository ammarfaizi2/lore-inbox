Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293620AbSBZWoA>; Tue, 26 Feb 2002 17:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293619AbSBZWnu>; Tue, 26 Feb 2002 17:43:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13062 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293618AbSBZWnp>; Tue, 26 Feb 2002 17:43:45 -0500
Subject: Re: i810_audio support
To: fooooobar@hotmail.com (Jason Algol)
Date: Tue, 26 Feb 2002 22:58:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F227XhGJPohZC46seCo00014395@hotmail.com> from "Jason Algol" at Feb 26, 2002 09:59:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fqYG-0002N1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I dont know very much about the workings of sound cards, but the problem is 
> that when playing anything a total crackling in the background that makes 
> the audio almost unusable...a real pity.

There are plenty of funnies in the i810 audio (actually mostly the driver
just doesn't seem to want to lie down and behave not such the hardware).
The crackling audio isn't one of the problems seen anywhere.

What AC97 codec is attached to your card, and also does it help if you
turn volume levels down a bit and turn all the recording inputs right off ?
