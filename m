Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265558AbRFVWqk>; Fri, 22 Jun 2001 18:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265559AbRFVWqU>; Fri, 22 Jun 2001 18:46:20 -0400
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:24033 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265558AbRFVWqQ>; Fri, 22 Jun 2001 18:46:16 -0400
Message-ID: <9319DDF797C4D211AC4700A0C96B7C9404AC2094@orsmsx42.jf.intel.com>
From: "Raj, Ashok" <ashok.raj@intel.com>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: signals and user mode interaction...
Date: Fri, 22 Jun 2001 15:46:08 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Is there a method to stack signals? i.e when multiple signals are delivered 
to the process, instead of being 1 shot, that signals get delivered as many
times?

and from kernel mode, can we pass arguments in the signal handler? for eg:
if i have SIGUSR1 for each
signal delivered by the kernel, i would like to pass some special parameter
to the signal handler.?

ashokr

--
Ashok Raj
Phone: (503)-712-5966
Intel Enterprise Product Group - Fabric Components Division (FCD)	Fax:
(503)-712-1429
Mail Stop: JF5-361
5200, NE Elam Young Parkway
Hillsboro, OR - 97124



