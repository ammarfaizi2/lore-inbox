Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbVL0Huh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVL0Huh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 02:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVL0Hug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 02:50:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14050 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932199AbVL0Hug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 02:50:36 -0500
Subject: Re: ia_64_bit Performance difference
From: Arjan van de Ven <arjan@infradead.org>
To: Nauman Tahir <nauman.tahir@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <f0309ff0512262318r6d06292u7b151f2608b286cf@mail.gmail.com>
References: <f0309ff0512262318r6d06292u7b151f2608b286cf@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 27 Dec 2005 08:50:31 +0100
Message-Id: <1135669831.2926.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-27 at 12:18 +0500, Nauman Tahir wrote:
> Hi all,
> I have written a block device driver. Driver includes the
> implementation of write back cache policy. Purpose of the driver is
> not an issue. The problem I am facing is the considerable difference
> of performance when I run same driver on 32 and 64 BIT OS. I am
> testing the driver on 64 Bit Machine and run the same driver on both
> (32 and 64 Bit) OS. On 32 Bit, IO rate is almost double then on 64 Bit
> OS. ( i wish it could have been opposite :( )

you forgot to post the URL to your source code...


