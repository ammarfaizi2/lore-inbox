Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273748AbRI3QfO>; Sun, 30 Sep 2001 12:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273749AbRI3QfE>; Sun, 30 Sep 2001 12:35:04 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:54028 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S273748AbRI3Qes>; Sun, 30 Sep 2001 12:34:48 -0400
Message-Id: <200109301635.f8UGZ0Y62800@aslan.scsiguy.com>
cc: ookhoi@dds.nl, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac17 Adaptec AIC7XXX problems (new driver, old one works fine) (solved) 
In-Reply-To: Your message of "Sun, 30 Sep 2001 10:13:27 MDT."
             <200109301613.f8UGDRY62473@aslan.scsiguy.com> 
Date: Sun, 30 Sep 2001 10:35:00 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The aic7xxx's register space only supports 8byte accesses.  The driver
					     ^byte^bit

--
Justin
