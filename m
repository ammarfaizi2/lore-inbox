Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbUCELdn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 06:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbUCELdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 06:33:43 -0500
Received: from [62.233.173.118] ([62.233.173.118]:19467 "EHLO eltekenergy.pl")
	by vger.kernel.org with ESMTP id S262501AbUCELdl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 06:33:41 -0500
Date: Fri, 5 Mar 2004 12:33:43 +0100 (CET)
From: =?ISO-8859-2?Q?Damian_Wojs=B3aw?= <damian.wojslaw@eltekenergy.pl>
X-X-Sender: damian@118.eltek
To: Juan Pablo Abuyeres <jpabuyer@tecnoera.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3 + reiser + quota support
In-Reply-To: <1078439292.16283.49.camel@blackbird.tecnoera.com>
Message-ID: <Pine.LNX.4.44.0403051232470.3537-100000@118.eltek>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-Spam-Score: -4.4 (----)
X-Spam-Report: -------------------- Start SpamAssassin results ----------------------
	This mail is probably spam.  The original message has been altered
	so you can recognise or block similar unwanted mail in future.
	See http://spamassassin.org/tag/ for more details.
	Content analysis details:   (-4.4 hits, 5.0 required)
	-4.4 IN_REP_TO              'In-Reply-To' line found
	-------------------- End of SpamAssassin results ---------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [root@test mnt]#
> and /var/log/messages says:
> Mar  4 19:15:46 test kernel: reiserfs_getopt: unknown option "usrquota"

	If I remember correclty, reiserfs needs an additional patch to
support quota. I know this patch exists for 2.4.X kernels.

-- 
Damian Wojs³aw
IT Departament
Eltek Polska Sp. z o. o., Poland

