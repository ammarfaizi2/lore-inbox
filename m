Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272067AbRHWBKu>; Wed, 22 Aug 2001 21:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272073AbRHWBKk>; Wed, 22 Aug 2001 21:10:40 -0400
Received: from mail.deja.com ([65.195.161.135]:45580 "EHLO mail.deja.com")
	by vger.kernel.org with ESMTP id <S272067AbRHWBK0>;
	Wed, 22 Aug 2001 21:10:26 -0400
From: "Jeff Busch" <jbusch@half.com>
To: "David Lang" <dlang@diginsite.com>
Cc: <linux-kernel@vger.kernel.org>, <roswell-list@redhat.com>
Subject: RE: [problem] RH 2.4.7-2 kernel slows to a crawl under heavy i/o
Date: Wed, 22 Aug 2001 20:10:40 -0500
Message-ID: <NEBBJGKHGENBAPAMDILGMEGOGOAA.jbusch@half.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.33.0108221633280.3868-100000@dlang.diginsite.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have been trying to duplicate a similar problem in my lab that happened
> to me on a production box with 2.4.5. do you have a test that will allow
> you to replicate the problem at will?

This problem only occured under live traffic on a production box.  Our
normal sanity checks worked fine, but they only generate light traffic.  The
running code and the data are proprietary, so I can't hand 'em out.  I'll
see if we can come up with a generic case that replicates the problem.

-Jeff

