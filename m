Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbTJOUVv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 16:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTJOUVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 16:21:51 -0400
Received: from 28-207.surfsnel.dsl.internl.net ([145.99.207.28]:41345 "EHLO
	pangsit.kjoe.net") by vger.kernel.org with ESMTP id S264278AbTJOUVu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 16:21:50 -0400
Date: Wed, 15 Oct 2003 22:21:48 +0200
To: Atte =?iso-8859-15?Q?Andr=E9?= Jensen <atte@ballbreaker.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: orinoco wireless pcmcia driver in test5
Message-ID: <20031015202147.GA2615@pangsit>
References: <20031015213013.5244bb4c.atte@ballbreaker.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015213013.5244bb4c.atte@ballbreaker.dk>
X-Mailer: Mutt on Debian GNU/Linux sid
X-Editor: vim
X-Organisation: SURFnet bv
X-Address: Radboudburcht, P.O. Box 19035, 3501 DA Utrecht, NL
X-Phone: +31 302 305 305
X-Telefax: +31 302 305 329
User-Agent: Mutt/1.5.4i
From: Niels den Otter <otter@surfnet.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atte,

On Wednesday, 15 October 2003, Atte Andr? Jensen wrote:
> What is the result (and purpose) of no mention of the orinoco wireless
> drivers in the .config for test5?
> 
> [atte@aarhus atte]$ grep -i orinoco /usr/src/linux-2.6.0-test5/.config
> [atte@aarhus atte]$ 
> 
> Will the driver be linked in anyhow? If not is there a fix?

Please check the configuration options for "HERMES".


-- Niels
