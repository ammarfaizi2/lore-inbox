Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285122AbRLFMGv>; Thu, 6 Dec 2001 07:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285123AbRLFMGm>; Thu, 6 Dec 2001 07:06:42 -0500
Received: from [213.96.124.18] ([213.96.124.18]:44523 "HELO dardhal")
	by vger.kernel.org with SMTP id <S285122AbRLFMGY>;
	Thu, 6 Dec 2001 07:06:24 -0500
Date: Thu, 6 Dec 2001 13:06:18 +0100
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: making an ide hd sleep
Message-ID: <20011206120618.GA3287@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <002d01c17e48$6df98a20$1300a8c0@marcelo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <002d01c17e48$6df98a20$1300a8c0@marcelo>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 06 December 2001, at 09:23:28 -0200,
Marcelo Borges Ribeiro wrote:

> Hi, I´d like to know if it's possible to put an ide hd to sleep after (for
> example) 15 min. idle (i don´t know if an hd under linux stays  idle that
> amount of time. ). I tried mount -o noatime and hdparm -S 150 /dev/hda, but
> it seems that when it sleeps it starts working after a few seconds (when it
> sleeps!). Is there a way to have this feature under linux?
> 
man hdparm

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

