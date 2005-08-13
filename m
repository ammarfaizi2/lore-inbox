Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVHMKLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVHMKLn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 06:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVHMKLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 06:11:43 -0400
Received: from lantana.tenet.res.in ([202.144.28.166]:13206 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S932146AbVHMKLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 06:11:42 -0400
Date: Sat, 13 Aug 2005 15:42:37 +0530 (IST)
From: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: starting a user defined daemon at linux startup.
In-Reply-To: <7d15175e05080403145a151b79@mail.gmail.com>
Message-ID: <Pine.LNX.4.60.0508131537410.14649@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0508041317360.5451@lantana.cs.iitm.ernet.in>
 <7d15175e05080403145a151b79@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hai
   I want to start a daemon at startup in linux.
I came to know that we need to put a script into /etc/rc.d/init.d/
similar to sshd or atd. Do we need to write a script to run my daemon?

But my daemon is just a single executable, is there any othr way to do 
this.

Thanks In Advance.
P.manohar.

