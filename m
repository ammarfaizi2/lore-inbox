Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262274AbRERIRY>; Fri, 18 May 2001 04:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262273AbRERIRN>; Fri, 18 May 2001 04:17:13 -0400
Received: from smtp-rt-14.wanadoo.fr ([193.252.19.224]:64159 "EHLO
	adansonia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262271AbRERIRG>; Fri, 18 May 2001 04:17:06 -0400
Subject: Re: Linux scalability?
From: "reiser.angus" <reiser.angus@wanadoo.fr>
To: Sasi Peter <sape@iq.rulez.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105180914560.29042-100000@iq.rulez.org>
In-Reply-To: <Pine.LNX.4.33.0105180914560.29042-100000@iq.rulez.org>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 18 May 2001 10:12:34 +0200
Message-Id: <990173560.6346.0.camel@adslgw>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However, taking a closer look, it turns out, that the above statement
> holds true only for 1 and 2 processor machines. Scalability already
> suffers at 4 processors, and at 8 processors, TUX 2.0 (7500) gets beaten
> by IIS 5.0 (8001), and these were measured on the same kind of box!
not really the same box
look at the disk subsystem
7 x 9GB 10KRPM Drives and 1 x 18GB 15KRPM (html+log & os) for Win2000
5 x 9GB 10KRPM Drives (html+log+os) for TUX 2.0

this is sufficient for a such difference

-David

