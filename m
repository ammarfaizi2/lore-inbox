Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274513AbRJADpV>; Sun, 30 Sep 2001 23:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274520AbRJADpL>; Sun, 30 Sep 2001 23:45:11 -0400
Received: from [216.218.213.232] ([216.218.213.232]:61329 "EHLO ontero.com")
	by vger.kernel.org with ESMTP id <S274513AbRJADpA>;
	Sun, 30 Sep 2001 23:45:00 -0400
From: "Tal Dayan" <tal@zapta.com>
To: <linux-kernel@vger.kernel.org>
Subject: CPU usage 'leak' with port redirection
Date: Sun, 30 Sep 2001 20:45:21 -0700
Message-ID: <LOBBJKOICNAKIBJGONPJOEOLAAAB.tal@zapta.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <200109282157.OAA07885@gormenghast.vista>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I am new to this list.

We are straggling for several months with the bug documented at
http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=46665 and we positively
confirmed that the problem disappears when we remove the redirection from
the
ipchains script.

Is there any formal procedure or a place to submit kernel related bugs ? I
could not
find anything about it at www.kernel.org.

Also, is the redirection code of the kernel shared between ipchains and
iptables or is it possible that the bug will not manifest itself if
we switch to iptables.

(we are using Linux version 2.4.2-2, Red Hat Linux 7.1 2.96-79)

Any help will be greatly appreciated,

Tal

