Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288716AbSA0VTB>; Sun, 27 Jan 2002 16:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288686AbSA0VSv>; Sun, 27 Jan 2002 16:18:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38922 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288732AbSA0VSj>; Sun, 27 Jan 2002 16:18:39 -0500
Subject: Re: When will CLONE_THREAD be available in a thread package?
To: george@mvista.com (george anzinger)
Date: Sun, 27 Jan 2002 20:56:52 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3C4C9122.384C675C@mvista.com> from "george anzinger" at Jan 21, 2002 02:07:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16UwM8-0002hb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A bit off topic, but....
> 
> CLONE_THREAD has been in the kernel for a bit, but is their a threads
> package for user land that uses it?  If not when?

Right at the moment nothing uses it - and its rather useless. I've been going
over the small version of the ibm patches which do finally seem to offer a
way to get the signal behaviour for posix thread crap right without punishing
sane programming.


