Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284467AbRLEQed>; Wed, 5 Dec 2001 11:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284472AbRLEQeN>; Wed, 5 Dec 2001 11:34:13 -0500
Received: from gap.cco.caltech.edu ([131.215.139.43]:33773 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S284462AbRLEQeD>; Wed, 5 Dec 2001 11:34:03 -0500
Message-Id: <5.0.2.1.0.20011205170157.01a7ae98@pop.mail.yahoo.fr>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Wed, 05 Dec 2001 17:05:05 +0100
To: mlist-linux-kernel@nntp-server.caltech.edu
From: Romain Giry <romain_giry@yahoo.fr>
Subject: 
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

i would like to know how the network layer does to know what is the upper 
layer protocol in order to fill in correctly the protocol field in the 
header it adds to the packet before sending it. I'm doing a ethernet device 
that doesn't add any header to the packet but change the output device, 
then i should say the network device that the packet is like if it has been 
sent by the ip protocol.

Thanks,

Romain Giry


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

