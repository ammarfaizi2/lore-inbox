Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264045AbUEXGd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUEXGd7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 02:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbUEXGd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 02:33:59 -0400
Received: from tag.witbe.net ([81.88.96.48]:6161 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S264045AbUEXGd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 02:33:57 -0400
Message-Id: <200405240633.i4O6Xu621252@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Phy Prabab'" <phyprabab@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Help understanding slow down
Date: Mon, 24 May 2004 08:33:49 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040524005751.62303.qmail@web90006.mail.scd.yahoo.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcRBKkN+knp0sTx/QzOxjxYLepHYZgALoQqQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

> 2.6.7-p1:
> 24.86user 51.77system 2:58.87elapsed 42%CPU
> (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (13major+7591686minor)pagefaults
> 0swaps
> 
> 2.4.21:
> 28.68user 34.98system 1:12.34elapsed 87%CPU
> (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (5691267major+1130523minor)pagefaults
> 0swaps
> 
> 
> Both runs on the same machine with the same process
> (making headers).
> 
> Could someone give me some pointers/directions on
> where to look.

Any reason why there is such a difference in the pagefaults
numbers between 2.4.x and 2.6.x ????
Could it explain a part of the time differences ?

Paul


