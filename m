Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422700AbWHYPLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422700AbWHYPLP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWHYPLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:11:15 -0400
Received: from smarthost1.sentex.ca ([64.7.153.18]:61139 "EHLO
	smarthost1.sentex.ca") by vger.kernel.org with ESMTP
	id S964879AbWHYPLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:11:13 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Krzysztof Halasa'" <khc@pm.waw.pl>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'David Woodhouse'" <dwmw2@infradead.org>, <linux-serial@vger.kernel.org>,
       "'LKML'" <linux-kernel@vger.kernel.org>
Subject: RE: Serial custom speed deprecated?
Date: Fri, 25 Aug 2006 11:10:56 -0400
Organization: Connect Tech Inc.
Message-ID: <043301c6c858$aa2de6d0$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <m31wr6otlr.fsf@defiant.localdomain>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: On Behalf Of Krzysztof Halasa
> Not sure if we want int, uint, or long long for speed values :-)

Our max baud rate on any product is IIRC 1,8432,00. I checked with our
hardware guys, and they think the current theoretical upper limit is
around 30,000,000.

<words style="famous,last">
A uint ought to be enough for anybody.
</words>

..Stu

