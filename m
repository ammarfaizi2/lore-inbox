Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267100AbTGHKQR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 06:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267106AbTGHKQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 06:16:17 -0400
Received: from smtp1.libero.it ([193.70.192.51]:25226 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S267100AbTGHKQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 06:16:16 -0400
Subject: Re: [RFC] [PATCH] LIRC drivers for 2.5
From: Flameeyes <dgp85@users.sourceforge.net>
To: Boszormenyi Zoltan <zboszor@freemail.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F0A9A79.6010809@freemail.hu>
References: <3F0A9A79.6010809@freemail.hu>
Content-Type: text/plain
Message-Id: <1057660308.2449.2.camel@laurelin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 08 Jul 2003 12:31:49 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-08 at 12:18, Boszormenyi Zoltan wrote:
> lirc_i2c.c does not compile:
I know this problem, lirc_i2c is using the i2c driver from lm_sensors
project, in the 2.4 version, so need a quite total rewrite.
-- 
Flameeyes <dgp85@users.sf.net>

