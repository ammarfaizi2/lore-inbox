Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279933AbRJ3MEY>; Tue, 30 Oct 2001 07:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279935AbRJ3MEO>; Tue, 30 Oct 2001 07:04:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11538 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279933AbRJ3MEE>; Tue, 30 Oct 2001 07:04:04 -0500
Subject: Re: apm suspend broken ?
To: suonpaa@iki.fi (Samuli Suonpaa)
Date: Tue, 30 Oct 2001 12:10:52 +0000 (GMT)
Cc: pascal.lengard@wanadoo.fr (Pascal Lengard), linux-kernel@vger.kernel.org
In-Reply-To: <87snc1mjyd.fsf@puck.erasmus.jurri.net> from "Samuli Suonpaa" at Oct 30, 2001 01:43:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yXjJ-0006Hr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I, byt the way, had my Latitude suspend perfectly with 2.4.12-ac5.
> Now, with 2.4.13-ac[34] pressing Fn+Suspend just blanks the screen (it
> doesn't shut it off, _just_ blanks it) and hangs the machine.
> 
> Any ideas on how to proceed in order to find out where the problem
> lies?

Find exactly which -ac it broke in. If you do a binary search through a few
patch levels you should be able to pin it down. At that point I can chase it


Alan
