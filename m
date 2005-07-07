Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVGGGLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVGGGLw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 02:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVGGGLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 02:11:51 -0400
Received: from tag.witbe.net ([81.88.96.48]:48063 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S261161AbVGGGKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 02:10:53 -0400
Message-Id: <200507070610.j676AoD14062@tag.witbe.net>
Reply-To: <rol@witbe.net>
From: "Paul Rolland" <rol@witbe.net>
To: "'Jeff Woods'" <Kazrak+kernel@cesmail.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: "Spy'ing" characters sent thru serial port ?
Date: Thu, 7 Jul 2005 08:10:50 +0200
Organization: Witbe
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <6.2.3.4.0.20050706214134.03ce1d00@no.incoming.mail>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcWCp/h82vuuFxUUSEGcTgp1qgJxQwAEjmxw
X-NCC-RegID: fr.witbe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

> I don't have any software answers, but it sounds like the modem is an 
> external type connected by RS232 cable to a serial port.  RS-232 is 
> pretty simple at the hardware level and you should be able to create 
> a "Y" cable that "sniffs" the transmit from the computer to modem 
> line without interrupting the dialogue between the serial port and 
> modem. Just connect the transmit and signal ground lines to the 
> receive and signal ground lines of a serial terminal or another 
> computer with some terminal software (or even "cat </dev/serial1" or 
> similar) listening to the serial port.  Back in Ye Olde Days (1980s) 
> we used to diagnose modem problems like that all the time.

Sure, that's what we did... provided you have a physical access to
the machine to install such a cable and a second machine... 
But as my only real access is thru an Ethernet cable, I was trying to
identify a software solution.

However, it looks like we're gonna have to go to yours, and try to 
find a way to access the machine physically... 

Thx,
Paul

