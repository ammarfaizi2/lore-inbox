Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288828AbSANS5G>; Mon, 14 Jan 2002 13:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288896AbSANS4O>; Mon, 14 Jan 2002 13:56:14 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:41227 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S288878AbSANSyk>; Mon, 14 Jan 2002 13:54:40 -0500
Message-ID: <3C432969.3F98E538@linux-m68k.org>
Date: Mon, 14 Jan 2002 19:54:33 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Momchil Velikov <velco@fadata.bg>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020114064548.D22065@hq.fsmlabs.com> <Pine.LNX.4.33.0201141541140.29505-100000@serv> <20020114091801.A23139@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

yodaiken@fsmlabs.com wrote:

> > > is going to be an enormously important issue.  However, once you add SCHED_FIFO in the
> > > current scheme, this becomes more complex. And with preempt, you cannot even offer the
> > > assurance that once a process gets the cpu it will make _any_ advance at all.
> >
> > I'm not sure if I understand you correctly, but how is this related to
> > preempt?
> 
> It's pretty subtle. If there is no preempt, processes don't get preempted.
> If there is preempt, they can be preempted. Amazing isn't it?

I just can't win against such brilliant argumentation, I'm out.

bye, Roman
