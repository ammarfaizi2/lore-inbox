Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317180AbSFGNt0>; Fri, 7 Jun 2002 09:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317285AbSFGNtZ>; Fri, 7 Jun 2002 09:49:25 -0400
Received: from internal-bristol34.naxs.com ([216.98.66.34]:6781 "EHLO
	coredump.electro-mechanical.com") by vger.kernel.org with ESMTP
	id <S317287AbSFGNtY>; Fri, 7 Jun 2002 09:49:24 -0400
Date: Fri, 7 Jun 2002 09:44:44 -0400
From: William Thompson <wt@electro-mechanical.com>
To: Samuel Flory <sflory@rackable.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PDC20267 + RAID can't find raid device
Message-ID: <20020607094444.O7291@coredump.electro-mechanical.com>
In-Reply-To: <20020606111918.F7291@coredump.electro-mechanical.com> <1023391095.3423.112.camel@flory.corp.rackablelabs.com> <20020606152051.H7291@coredump.electro-mechanical.com> <1023391925.3700.142.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Are you sure you have the raid array configured in the fasttrak bios? 
> I don't think enabling brust should matter.  It's working for me:

As I said in my last email, this is a test machine right now.  I had a win
2000 image so I threw that on there to see if the array was actually there. 
It was.

I rebooted the machine into linux and it can't find any raid arrays.

Even a dos boot disk sees the array ok.
