Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261759AbRFAWdK>; Fri, 1 Jun 2001 18:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261793AbRFAWdA>; Fri, 1 Jun 2001 18:33:00 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:58472 "EHLO
	c0mailgw02.prontomail.com") by vger.kernel.org with ESMTP
	id <S261759AbRFAWc4> convert rfc822-to-8bit; Fri, 1 Jun 2001 18:32:56 -0400
Message-ID: <3B1817DD.48A91CB8@mvista.com>
Date: Fri, 01 Jun 2001 15:31:57 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dieter =?iso-8859-15?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: missing sysrq
In-Reply-To: <Pine.LNX.4.10.10106011050380.2614-100000@coffee.psychology.mcmaster.ca> <20010601203841Z261493-933+3160@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:
> 
> Am Freitag, 1. Juni 2001 16:51 schrieben Sie:
> > > Have you tried "echo 1 > /proc/sys/kernel/sysrq"?
> > > You need both, compiled in and activation.
> >
> > no, look at the code.  the enable variable defaults to 1.
> 
> Then there must be a bug?
> I get "0" with 2.4.5-ac2 and -ac5 without "echo 1".
> 
> Fresh booted 2.4.5-ac2:

Bet not!  Most distro scripts turn it off on the way up.  Sometimes it
is a bit hard to find where they do it too.

George
