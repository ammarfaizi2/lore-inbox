Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267851AbUHXOP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267851AbUHXOP5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 10:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267856AbUHXOP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 10:15:56 -0400
Received: from [213.188.213.77] ([213.188.213.77]:50405 "EHLO
	server1.navynet.it") by vger.kernel.org with ESMTP id S267851AbUHXOPx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 10:15:53 -0400
From: "Massimo Cetra" <mcetra@navynet.it>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Production comparison between 2.4.27 and 2.6.8.1
Date: Tue, 24 Aug 2004 16:15:42 +0200
Message-ID: <002401c489e4$d7903ec0$0600640a@guendalin>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
In-Reply-To: <412AA25E.8060509@yahoo.com.au>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> > Is this issue being analyzed ?
> > Should we hope in an improvement sometime?
> > Or I'll have to use 2.4 to have good performance ?
> > 
> 
> You booted with elevator=deadline and things still didn't 
> improve though, correct? If so, then the problem should be 
> found and fixed.

Yes, that's correct.
Thanks.  I'll try next versions of kernel.
I dont think 2.8.9-RC1 includes something regarding this issue.


Max

