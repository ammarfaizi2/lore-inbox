Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318040AbSHVXcx>; Thu, 22 Aug 2002 19:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318059AbSHVXcx>; Thu, 22 Aug 2002 19:32:53 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:63476 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318040AbSHVXcx>; Thu, 22 Aug 2002 19:32:53 -0400
Subject: Re: APM/Sound on a Dell Inspiron 3500 fix.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jerry@linuxscripts.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208221518430.4469-100000@vader.zolan.org>
References: <Pine.LNX.4.44.0208221518430.4469-100000@vader.zolan.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 23 Aug 2002 00:38:14 +0100
Message-Id: <1030059494.3090.101.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-22 at 23:46, jerry@linuxscripts.com wrote:
> It seems to me that the problem would be with this laptop's apm on bios 
> level.  However, it seems that the sb module does some sort of 
> re-initialize to the sound device that the ad1848 fails to do.  I'm not 
> sure what the correct fix is, but I, and others with the same laptop, 
> would be happy if someone could take this information and maybe come up 
> with a better solution to the problem.

Its tricky to deal with, and the OSS code is dying so I dont care enough
to try and work on it. From a user perspective the apmd scripts are your
friend 8)

