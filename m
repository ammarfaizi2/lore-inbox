Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274116AbRISRbj>; Wed, 19 Sep 2001 13:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274117AbRISRba>; Wed, 19 Sep 2001 13:31:30 -0400
Received: from [213.96.124.18] ([213.96.124.18]:55274 "HELO dardhal")
	by vger.kernel.org with SMTP id <S274116AbRISRbV>;
	Wed, 19 Sep 2001 13:31:21 -0400
Date: Wed, 19 Sep 2001 19:33:41 +0000
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 Success story
Message-ID: <20010919193341.B527@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010918192003.5C326783ED@mail.clouddancer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010918192003.5C326783ED@mail.clouddancer.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 18 September 2001, at 12:20:03 -0700,
Colonel wrote:

> A brief note of _thanks_ to all that create the linux kernel.
> [...]
> This particular gem of a kernel is:
> 
> 2.4.9-ac10 #1 SMP Tue Sep 11 21:47:15 PDT 2001 i686
> 
>From my particular experience with a couple of very low-end computers
moderately loaded (mainly used as workstations) I can say that in _my_ own
setup and hardware, memory management in 2.4.9-ac10 feels much better than
2.4.9's. In 2.4.9-ac10 I've been using:
echo "1" > /proc/sys/vm/page_aging_tactic

and the result is a much better behavior of the system. Now, with the same
applications loaded, daily cron doesn't force all of my appliactions into
swap (something 2.4.9 did). Now swap usage is much lower, the system seems
to have a faster response to user interaction than before and "swapoff" is
_much_ (maybe x10) faster than in 2.4.9.

It seems that we are getting closer to a production-quality kernel :)

-- 
José Luis Domingo López
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

