Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269125AbRHBU1m>; Thu, 2 Aug 2001 16:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269118AbRHBU1d>; Thu, 2 Aug 2001 16:27:33 -0400
Received: from pc1-cwbl2-0-cust80.cdf.cable.ntl.com ([62.252.63.80]:61678 "EHLO
	bagpuss.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S269115AbRHBU1S>; Thu, 2 Aug 2001 16:27:18 -0400
From: Alan Cox <alan@bagpuss.swansea.linux.org.uk>
Message-Id: <200107292127.f6TLRpC01583@bagpuss.swansea.linux.org.uk>
Subject: Re: [Linux Diffserv] Re: [PATCH] Inbound Connection Control mechanism:
To: samudrala@us.ibm.com (Sridhar Samudrala)
Date: Sun, 29 Jul 2001 17:27:50 -0400 (EDT)
Cc: hadi@cyberus.ca (jamal), diffserv-general@lists.sourceforge.net,
        kuznet@ms2.inr.ac.ru, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        rusty@rustcorp.com.au, thiemo@sics.se,
        samudrala@us.ibm.com (Sridhar Samudrala),
        tewarir@us.ibm.com (Renu Tewari), dmfreim@us.ibm.com
In-Reply-To: <Pine.LNX.4.21.0107301359350.23307-100000@w-sridhar2.des.sequent.com> from "Sridhar Samudrala" at Jul 30, 2001 03:08:34 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Our patch can be used along with SYN policing to prioritize incoming
> connection requests on a socket. SYN policing can be used to limit 
> the rate of a particular class, but it cannot be used to prioritize a 

No. Because you cant prove the packets are not spoofed. An attacker 
becomes able to block classes

