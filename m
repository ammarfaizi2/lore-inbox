Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269517AbRHTVoq>; Mon, 20 Aug 2001 17:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269489AbRHTVo0>; Mon, 20 Aug 2001 17:44:26 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:25354 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S269481AbRHTVoW>; Mon, 20 Aug 2001 17:44:22 -0400
Message-Id: <200108202144.f7KLiYY43268@aslan.scsiguy.com>
To: Cliff Albert <cliff@oisec.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo 
In-Reply-To: Your message of "Mon, 20 Aug 2001 23:04:10 +0200."
             <20010820230410.A28323@oisec.net> 
Date: Mon, 20 Aug 2001 15:44:34 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>And here they are, the dmesg is my bootup dmesg with the devices drivers 
>and stuff, and the second dmesg is the actual errors (verbose turned on)

You need OFOJ or better firmware in your Fireball ST.  The firmware you
have now is known to be bad.  Before Maxtor's purchase of Quantum's
disk line, you used to be able to get firmware updates off of
ftp.quantum.com, but they've hence cleared out those files.  In a
quick look through Maxtor's site, I could not find the relevant files.

--
Justin
