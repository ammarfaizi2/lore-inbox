Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130405AbRA1FSS>; Sun, 28 Jan 2001 00:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130509AbRA1FR6>; Sun, 28 Jan 2001 00:17:58 -0500
Received: from cambot.suite224.net ([209.176.64.2]:50184 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S130405AbRA1FRv>;
	Sun, 28 Jan 2001 00:17:51 -0500
From: "Matthew Pitts" <mpitts@suite224.net>
Subject: Re: Knowing what options a kernel was compiled with 
To: Keith Owens <kaos@ocs.com.au>, Jacob Anawalt <anawaltaj@qwest.net>
Cc: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro Web Mailer v.3.4b2a
Date: Sun, 28 Jan 2001 00:13:48 -0500
Message-ID: <web-2874335@suite224.net>
In-Reply-To: <4504.980658417@ocs3.ocs-net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jan 2001 16:06:57 +1100
 Keith Owens <kaos@ocs.com.au> wrote:
> On Sat, 27 Jan 2001 22:21:41 -0700, 
> Jacob Anawalt <anawaltaj@qwest.net> wrote:
> >Is there a way to know what options a running kernel was
> compiled with,
> >if you dont have access to the source or configure files
> it was compiled
> >off of?
> 
> No.  You have to insist that whoever distributes the
> kernel binary also
> distributes the .config file that it was compiled with.
> 
> Don't bother arguing that the kernel should record this
> info, it has
> been discussed before and rejected.  This is a problem
> for the
> distributors, not for the kernel.
Keith and Jacob,
Some distributions DO include the config. It may be located
in the /boot dir with a name CONFIG-2.2.10 or similar. I
know that Caldera 2.3 shiped that way(2.4 may also). If you
have the install CDROM, the kernel source install may have
it (e.g. Linux-Mandrake 7.x).

Matthew
mpitts@suite224.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
