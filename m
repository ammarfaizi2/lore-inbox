Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284558AbRLESnQ>; Wed, 5 Dec 2001 13:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284554AbRLESnG>; Wed, 5 Dec 2001 13:43:06 -0500
Received: from [213.96.124.18] ([213.96.124.18]:1771 "HELO dardhal")
	by vger.kernel.org with SMTP id <S284543AbRLESmy>;
	Wed, 5 Dec 2001 13:42:54 -0500
Date: Wed, 5 Dec 2001 19:42:46 +0100
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: raw devices & software raid
Message-ID: <20011205194245.A2145@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200112051106.fB5B6VQ24498@mail.swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200112051106.fB5B6VQ24498@mail.swissonline.ch>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 05 December 2001, at 12:06:11 +0100,
LLX wrote:

> i want to create a raid devices with raid 
> level 0 that does raw i/o. 
> 
Check this:
http://www.suse.com/en/support/oracle/docs/lvm_whitepaper.pdf

It is about LVM, but RAID should also work with respect to raw I/O.

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

