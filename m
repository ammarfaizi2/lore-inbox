Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273382AbRIWLlT>; Sun, 23 Sep 2001 07:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273414AbRIWLlK>; Sun, 23 Sep 2001 07:41:10 -0400
Received: from [213.96.124.18] ([213.96.124.18]:20974 "HELO dardhal")
	by vger.kernel.org with SMTP id <S273382AbRIWLlC>;
	Sun, 23 Sep 2001 07:41:02 -0400
Date: Sun, 23 Sep 2001 13:42:33 +0000
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Whats in the wings for 2.5 (when it opens)
Message-ID: <20010923134232.A5315@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010918001826.7D118A0E5@oscar.casa.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010918001826.7D118A0E5@oscar.casa.dyndns.org>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 17 September 2001, at 20:18:25 -0400,
Ed Tomlinson wrote:

> Hi,
> 
> Seems like there is a lot of code "ready" for consideration in a 2.5 kernel.
> I can think of:
> [...]
>
Maybe this is something worth to have a look at:
http://evlog.sourceforge.net/

It seems to be an "enterprise-class advanced event logging system for
Linux", trying toi be compliant with upcoming POSIX Standard 1003.25,
"System API - Services for Reliable, Available, and Serviceable Systems".

It requires kernel patches and userspace logging daemon to work. Kernel
patches are available for 2.4.4 and as I can see from the kernel patch, it
is little intrusive (hardly any changes to existing kernel code, and adds
a couple of new files). It also requires a patched glibc, but the required
patch (for glibc2.2.3) is very little.

--
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

