Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129612AbRCCPO1>; Sat, 3 Mar 2001 10:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129602AbRCCPOQ>; Sat, 3 Mar 2001 10:14:16 -0500
Received: from 2-081.cwb-adsl.telepar.net.br ([200.193.161.81]:57840 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129599AbRCCPN7>; Sat, 3 Mar 2001 10:13:59 -0500
Date: Sat, 3 Mar 2001 10:35:14 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Steven Brooks <umbrook0@cs.umanitoba.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: block loop device hangs
Message-ID: <20010303103514.B4734@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Steven Brooks <umbrook0@cs.umanitoba.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3AA10876.7050906@cs.umanitoba.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <3AA10876.7050906@cs.umanitoba.ca>; from umbrook0@cs.umanitoba.ca on Sat, Mar 03, 2001 at 09:06:30AM -0600
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Mar 03, 2001 at 09:06:30AM -0600, Steven Brooks escreveu:
> When mounting a file using the loopback device, the mount program hangs
> for ever.  Other than that, the system is still usable.
> 
> Dist: Redhat-7
> Kernel: 2.4.2 (compiled with kgcc, i.e. egcs-2.91.66)

FAQ, try 2.4.2-ac10, several fixes to looback device

- Arnaldo
