Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265636AbSLMXsz>; Fri, 13 Dec 2002 18:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbSLMXsz>; Fri, 13 Dec 2002 18:48:55 -0500
Received: from dsl-213-023-066-131.arcor-ip.net ([213.23.66.131]:17559 "EHLO
	neon.pearbough.net") by vger.kernel.org with ESMTP
	id <S265636AbSLMXsy>; Fri, 13 Dec 2002 18:48:54 -0500
Date: Sat, 14 Dec 2002 00:55:05 +0100
From: axel@pearbough.net
To: lartc@mailman.ds9a.nl, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: Compiling iproute2(w/HTB patch) for 2.5.51
Message-ID: <20021213235505.GA32084@neon.pearbough.net>
Mail-Followup-To: lartc@mailman.ds9a.nl, linux-kernel@vger.kernel.org,
	kuznet@ms2.inr.ac.ru
References: <20021213234959.GA31994@neon.pearbough.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021213234959.GA31994@neon.pearbough.net>
User-Agent: Mutt/1.4i
Organization: pearbough.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again!

On Sat, 14 Dec 2002, axel@pearbough.net wrote:

> having read an article about QoS and HTB in a German computer magazine I
> wanted to implement such thing on my linux router running kernel 2.5.51.
> First I patched the iproute2-020116.tar.gz package with the htb3.6_tc.diff 
> from http://luxik.cdi.cz/~devik/qos/htb/ and started building it. But
> unfortunately it resulted in strange compile errors I do not understand.
> 
> make[1]: *** [ss.o] Error 1
> make[1]: Leaving directory /usr/local/src/iproute2/misc'

There are no such problems with 2.4.20.

Axel
