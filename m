Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316848AbSEVEFa>; Wed, 22 May 2002 00:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316851AbSEVEF3>; Wed, 22 May 2002 00:05:29 -0400
Received: from viper.haque.net ([66.88.179.82]:8129 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S316848AbSEVEF2>;
	Wed, 22 May 2002 00:05:28 -0400
Date: Wed, 22 May 2002 00:05:24 -0400 (EDT)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: linux-kernel@vger.kernel.org
Subject: ip alias and default outgoing interface
Message-ID: <Pine.LNX.4.44.0205220003060.3979-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a setup where I have one ethernet card and multiple ips 
assigned using ip alias.

i've noticed that sometimes out going traffic goes out using the ip of 
the last interface I brought up.

Is this supposed to happen? How do I make it so that the default gw 
interface is used?

Thanks

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix. 
   Don't drink and derive." --Unknown 

=====================================================================

