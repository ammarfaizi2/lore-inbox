Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272122AbRI3AMH>; Sat, 29 Sep 2001 20:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272135AbRI3AL5>; Sat, 29 Sep 2001 20:11:57 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:27147 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S272122AbRI3ALm>; Sat, 29 Sep 2001 20:11:42 -0400
Message-Id: <200109300012.f8U0C1Y58146@aslan.scsiguy.com>
To: arjan@fenrus.demon.nl
cc: ookhoi@dds.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac17 Adaptec AIC7XXX problems (new driver, old one works fine) 
In-Reply-To: Your message of "Sat, 29 Sep 2001 15:43:54 BST."
             <E15nLLO-00027M-00@fenrus.demon.nl> 
Date: Sat, 29 Sep 2001 18:12:01 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Yet another driver with bogus #ifdef around the module.h include.. sigh

I believe that this was fixed in v6.2.3 of the aic7xxx driver, but
I'm not in front of a machine right now where I can check.

--
Justin
