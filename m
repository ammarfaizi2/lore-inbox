Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311647AbSDNGP5>; Sun, 14 Apr 2002 02:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311670AbSDNGP4>; Sun, 14 Apr 2002 02:15:56 -0400
Received: from h24-83-104-254.sbm.shawcable.net ([24.83.104.254]:55462 "EHLO
	whiskey.enposte.net") by vger.kernel.org with ESMTP
	id <S311647AbSDNGPz>; Sun, 14 Apr 2002 02:15:55 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: sl@whiskey.enposte.net (Stuart Lynne)
Newsgroups: list.linux-kernel
Subject: Re: ux as a minicomputer ?
Date: Sun, 14 Apr 2002 06:16:00 +0000 (UTC)
Organization: enposte
Distribution: local
Message-ID: <a9b6r0$thc$1@whiskey.enposte.net>
In-Reply-To: <1018751811.22396@whiskey.enposte.net>
Reply-To: sl@enposte.net
NNTP-Posting-Host: whiskey.enposte.net
X-Trace: whiskey.enposte.net 1018764960 30252 192.168.40.16 (14 Apr 2002 06:16:00 GMT)
X-Complaints-To: usenet@whiskey.enposte.net
NNTP-Posting-Date: Sun, 14 Apr 2002 06:16:00 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: sl@whiskey.enposte.net (Stuart Lynne)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1018751811.22396@whiskey.enposte.net>,
jw schultz <jw@pegasys.ws> wrote:
>On Sat, Apr 13, 2002 at 12:29:23PM -0700, H. Peter Anvin wrote:
>
>Most medium to large workplaces are vast cubicle farms.  Put
>one box at the intersection of 4 cubes...bingo 2meter VGA
>cables reach fine and you get 1/4th the maintenance, 1/4 the
>network drops, etc.  This would even be advantagious for two desks
>side-by-side or back-to-back.  

I don't think you are reducing complexity very much if at all,
mostly just shuffling it around some.

You may have a quarter as many configurations to manage but will
each configuration be less than four times as hard to maintain?

Maybe, mabye not. I just don't think it's a clear win.

Also don't forget some of the other reasons for not doing it:
single point of failure, harder to maintain, lack of flexibility
etc.

