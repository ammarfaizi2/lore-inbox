Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268516AbSIRVZV>; Wed, 18 Sep 2002 17:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268540AbSIRVZV>; Wed, 18 Sep 2002 17:25:21 -0400
Received: from ulima.unil.ch ([130.223.144.143]:50305 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S268516AbSIRVZV>;
	Wed, 18 Sep 2002 17:25:21 -0400
Date: Wed, 18 Sep 2002 23:30:23 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: Steven Cole <elenstev@mesatop.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.36 oops at boot
Message-ID: <20020918213023.GC12696@ulima.unil.ch>
References: <20020918120321.GA6167@ulima.unil.ch> <1032376806.11913.130.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1032376806.11913.130.camel@spc9.esa.lanl.gov>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 01:20:06PM -0600, Steven Cole wrote:
> On Wed, 2002-09-18 at 06:03, Gregoire Favre wrote:
> > Hello,
> 
> > kernel BUG at sched.c:944!
> 
> Try this fix archived here. Should work with and without PREEMPT.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103236178722206&w=2

Oups, sorry, I'll test it!!!

Shame on me for not having checked it correctly :-((

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
