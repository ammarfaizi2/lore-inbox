Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136864AbREJRdx>; Thu, 10 May 2001 13:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136866AbREJRdn>; Thu, 10 May 2001 13:33:43 -0400
Received: from windsormachine.com ([206.48.122.28]:51973 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S136864AbREJRd3>; Thu, 10 May 2001 13:33:29 -0400
Message-ID: <3AFAD0DC.90510557@windsormachine.com>
Date: Thu, 10 May 2001 13:33:16 -0400
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.77 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ATAPI Tape Driver Failure in Kernel 2.4.4, More
In-Reply-To: <3AF9558F.9C76953C@tpr.com> <3AF9B411.2A0F3F43@tpr.com> <3AF9B876.FDB1B6DD@bigfoot.com> <3AFA8A1D.A9BBB4DF@tpr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Bratcher wrote:

>
> This all works OK in kernel 2.2.17. But it fails in 2.4.4.
> > hdd: HP COLORADO 20GB, ATAPI TAPE drive

I did my own playing with 2.4.x on the 14gb model of this tape drive, all i've managed
to do is be able to write to the tape, but not read from it.  Even in 2.2.x, putting the
IDE patches in, breaks it.  Apparently the HP's aren't completely ATAPI compatible

