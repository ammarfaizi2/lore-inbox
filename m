Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266953AbTAPAif>; Wed, 15 Jan 2003 19:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266948AbTAPAif>; Wed, 15 Jan 2003 19:38:35 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:11969 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S266944AbTAPAie>;
	Wed, 15 Jan 2003 19:38:34 -0500
Message-ID: <1042678048.3e260120a3047@kolivas.net>
Date: Thu, 16 Jan 2003 11:47:28 +1100
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: should be: cannot allocate memory : fork error on 2.5.58
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holy crap sorry about the subject. Dont know what happened there

Quoting Con Kolivas <conman@kolivas.net>:

> MIME-Version: 1.0
> Content-Type: text/plain; charset=ISO-8859-1
> Content-Transfer-Encoding: 8bit
> User-Agent: Internet Messaging Program (IMP) 3.1
> 
> 
> 
> Since moving contest (http://contest.kolivas.net) to c I get an error trying
> to
> fork with all 2.5 kernels I try after running it on the 6th load. The error
> does
> not occur with any 2.4 kernels. I have confirmed it is still present on
> 2.5.58.
> 
> To reproduce the problem:
> Run the latest version of contest without arguments (0.61pre) and after
> no_load,cacherun,process_load,ctar_load,xtar_load and io_load it bombs out
> with:
> bmark.c:43: SYSTEM ERROR: Cannot allocate memory : fork error
> 
> This is not an application error and does not occur with 2.4.x kernels. It
> happens every time and with all 2.5 kernels I have tried. I can start
> contest
> again without problems after each error and eventually will run into the same
> error.
> 
> Con
> 


