Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315055AbSDWEVa>; Tue, 23 Apr 2002 00:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315059AbSDWEV3>; Tue, 23 Apr 2002 00:21:29 -0400
Received: from mail.mojomofo.com ([208.248.233.19]:5644 "EHLO mojomofo.com")
	by vger.kernel.org with ESMTP id <S315055AbSDWEV2>;
	Tue, 23 Apr 2002 00:21:28 -0400
Message-ID: <073a01c1ea7e$43404970$0800a8c0@atlink30g>
From: "Aaron Tiensivu" <mojomofo@mojomofo.com>
To: "Jeff Garzik" <garzik@havoc.gtf.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <051a01c1ea6a$915711c0$0800a8c0@atlink30g> <20020422220658.A29096@havoc.gtf.org>
Subject: Re: 2.5.6 to 2.5.7 netfilter changes broke my squid cache
Date: Tue, 23 Apr 2002 00:20:49 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For drivers at least, you can probably copy your key drivers from 2.5.7
> into 2.5.5, and see what breaks...  If that eliminates the drivers, or
> signals a problematic driver, this may save you some time.

So far it looks like the netfilter changes that went into 2.5.7 from 2.5.6
is the culprit.
I'll know more tomorrow once I back them out manually.


