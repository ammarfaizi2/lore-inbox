Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130279AbRCBCLy>; Thu, 1 Mar 2001 21:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130277AbRCBCLl>; Thu, 1 Mar 2001 21:11:41 -0500
Received: from 2-072.cwb-adsl.telepar.net.br ([200.193.161.72]:10223 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S130288AbRCBCLf>; Thu, 1 Mar 2001 21:11:35 -0500
Date: Thu, 1 Mar 2001 21:32:48 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Chaskiel M Grundman <cg2v+@andrew.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC error on CPU0 (UP APIC kernel)
Message-ID: <20010301213248.J3217@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Chaskiel M Grundman <cg2v+@andrew.cmu.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <subjzA1z0001Q6c7QE@andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <subjzA1z0001Q6c7QE@andrew.cmu.edu>; from cg2v+@andrew.cmu.edu on Thu, Mar 01, 2001 at 09:05:00PM -0500
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 01, 2001 at 09:05:00PM -0500, Chaskiel M Grundman escreveu:
> 2.4 SMP kernels seem to work fine, but using a 2.4.1 or 2.4.2 UP kernel

can you try 2.4.2-ac8 and tell us the results?

> with CONFIG_X86_UP_IOAPIC does not. At some point before the real root
> filesystem is mounted, the system begins spewing 

- Arnaldo
