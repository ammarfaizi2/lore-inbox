Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310191AbSCAAmk>; Thu, 28 Feb 2002 19:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310231AbSCAAk2>; Thu, 28 Feb 2002 19:40:28 -0500
Received: from ns.suse.de ([213.95.15.193]:56838 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310296AbSCAAiC>;
	Thu, 28 Feb 2002 19:38:02 -0500
Date: Fri, 1 Mar 2002 01:37:58 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Dennis Jim <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Congrats Marcelo,
In-Reply-To: <E16gaUh-0001bB-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0203010137090.8089-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, Alan Cox wrote:

> > Nope. I could well integrate lm_sensors in the future.
> Please be careful. lm_sensors can destroy machines if configured wrongly.
> Thats something that needs tackling - and ironically ACPI may actually
> solve that problem

The machines in question are all IBMs iirc ? Could we work around
this with DMI strings for the suspect laptops ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

