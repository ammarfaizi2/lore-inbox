Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262336AbSJJWAP>; Thu, 10 Oct 2002 18:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262337AbSJJWAP>; Thu, 10 Oct 2002 18:00:15 -0400
Received: from mail3.efi.com ([192.68.228.90]:29448 "HELO
	fcexgw03.efi.internal") by vger.kernel.org with SMTP
	id <S262336AbSJJWAN>; Thu, 10 Oct 2002 18:00:13 -0400
Subject: minimon loadable binary kernel.
From: Frederic Roussel <frederic.roussel@efi.com>
To: LKML <linux-kernel@vger.kernel.org>,
       "Eduardo R. Tapia" <tapiae@bariloche.com.ar>,
       Ranjan Parthasarathy <ranjanp@efi.com>, Mark Tyler <Mark.Tyler@efi.com>
Cc: Alok Gupta <Alok.Gupta@efi.com>, Larry Klassen <Larry.Klassen@efi.com>,
       Brendan Creedon <Brendan.Creedon@efi.com>,
       Horacio Fontanini <fontanin@bariloche.com.ar>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Oct 2002 15:05:49 -0700
Message-Id: <1034287553.13799.38.camel@frasc>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

So I have released a kseg1 binary kernel with its matching System.map

http://south-pole.efi.com/twiki/bin/view/Osweb/EriscDocuments

The goal here is to get a trial run on VCS so that we can get an idea of
what trace/deug output we can get.

We will have to prototype all the various minimon hooks with you guys.

Joining my lonely kernel effort, there will Ranjan and to a lesser
extent (for the time being!) Mark. Please keep them in the loop.

I'll follow up later with Eduardo and Horacio regarding the minimon
interface. Don't worry HW guys, we won't bother you  that much ;-)

Later,

-- 
Frederic.R.Roussel         -o)                                    (o-
OS Group Manager           /\\  Join the penguin force  (o_  (o_  //\
                          _\_v   The Linux G3N3R47!0N   (/)_ (/)_ v_/_


