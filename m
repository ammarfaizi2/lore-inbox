Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318277AbSHUNLq>; Wed, 21 Aug 2002 09:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318283AbSHUNLq>; Wed, 21 Aug 2002 09:11:46 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:1278 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318277AbSHUNLp>; Wed, 21 Aug 2002 09:11:45 -0400
Subject: Re: shared graphic ram hangs kernel since 2.4.3-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Justin Heesemann <jh@ionium.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200208211352.29994.jh@ionium.org>
References: <200208201527.51649.jh@ionium.org> 
	<200208211352.29994.jh@ionium.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 14:16:52 +0100
Message-Id: <1029935812.26425.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 12:52, Justin Heesemann wrote:
> 2.4.19-pre7 with pre6  arch/i386/kernel/setup.c   works ! 
> as i dont have any highmem support configured and as i always have to provide 
> the option   mem=511M   (due to 1MB shared video ram) i suspect that part of 
> setup.c. but as i'm not a kernel hacker, any help would be appreciated.
> note: any kernel prior to 2.4.3 was able to boot without the mem=511M option.

Are you running a very old version of grub ?

