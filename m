Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319332AbSIFSyB>; Fri, 6 Sep 2002 14:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319334AbSIFSyA>; Fri, 6 Sep 2002 14:54:00 -0400
Received: from realityfailure.org ([209.150.103.212]:52869 "EHLO
	mail.realityfailure.org") by vger.kernel.org with ESMTP
	id <S319332AbSIFSx7>; Fri, 6 Sep 2002 14:53:59 -0400
Date: Fri, 6 Sep 2002 14:55:24 -0400 (EDT)
From: John Jasen <jjasen@realityfailure.org>
To: Bernd Schubert <bernd-schubert@web.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/ entries change owner
In-Reply-To: <200209062045.37478.bernd-schubert@web.de>
Message-ID: <Pine.LNX.4.44.0209061453520.14253-100000@geisha.realityfailure.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2002, Bernd Schubert wrote:

> Unfortunality this causes that no other user might use the floppy drive -- a 
> desaster in a multi user environment (our group has over 40 members).
> 
> This seems to happen to lots of devices (another example are tty's) and it is 
> distribution independent (I see it at home (Slackware) and at work (Suse)).
> 
> 
> Any suggestions what I could do ???

look in /etc/security/console.perms for a start.

-- 
-- John E. Jasen (jjasen@realityfailure.org)
-- User Error #2361: Please insert coffee and try again.



