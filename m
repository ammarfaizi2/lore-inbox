Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316747AbSGLSEG>; Fri, 12 Jul 2002 14:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316751AbSGLSEF>; Fri, 12 Jul 2002 14:04:05 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:9352 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316747AbSGLSEE>;
	Fri, 12 Jul 2002 14:04:04 -0400
Date: Fri, 12 Jul 2002 11:10:01 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: dipankar@in.ibm.com, Alexander Viro <viro@math.psu.edu>
cc: Maneesh Soni <maneesh@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [RFC] dcache scalability patch (2.4.17)
Message-ID: <15360000.1026497401@w-hlinder>
In-Reply-To: <20020712233205.B23363@in.ibm.com>
References: <20020712193935.B13618@in.ibm.com> <Pine.GSO.4.21.0207121021430.11261-100000@weyl.math.psu.edu> <20020712214008.A22916@in.ibm.com> <20020712233205.B23363@in.ibm.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, July 12, 2002 23:32:05 +0530 Dipankar Sarma <dipankar@in.ibm.com> wrote:

> 
> Hi Al,
> 
> Mark Hahn made a good point over private email that real-worldness
> also includes hardware. I will dig around and see if we can work out
> a setup with different dual/4CPU hardware to do webserver benchmarks 
> and analyze results for 2.5 patches.
> 

Dipankar,

	I just loaded a 2-way PII 400Mhz with 256Meg of ram which
is a lot more real world than most the other systems we test. It
is on the net (behind the ibm firewall of course) so you can use
it if you want. 

Hanna

