Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbRDHWLC>; Sun, 8 Apr 2001 18:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131233AbRDHWKx>; Sun, 8 Apr 2001 18:10:53 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:39433 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131158AbRDHWKp>; Sun, 8 Apr 2001 18:10:45 -0400
Date: Sun, 8 Apr 2001 23:10:27 +0100 (BST)
From: David Woodhouse <dwmw2@infradead.org>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: Matti Aarnio <matti.aarnio@zmailer.org>, <kumon@flab.fujitsu.co.jp>,
        Michael Peddemors <michael@linuxmagic.com>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: goodbye
In-Reply-To: <200104081356.PAA24042@cave.bitwizard.nl>
Message-ID: <Pine.LNX.4.30.0104082308030.16115-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Apr 2001, Rogier Wolff wrote:

> SMTP receivers should have the option of inserting a header line
> instead of blocking "bad" Emails. Then other layers can decide what to
> do with this Email.

http://www.exim.org/exim-html-3.20/doc/html/spec_46.html#SEC810

	rbl_domains = dul.maps.vix.com/warn

-- 
dwmw2


