Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272737AbTG1IlH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 04:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272750AbTG1IjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 04:39:14 -0400
Received: from lidskialf.net ([62.3.233.115]:39895 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S272749AbTG1IiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 04:38:20 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Marcelo Penna Guerra <eu@marcelopenna.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
Date: Mon, 28 Jul 2003 09:53:34 +0100
User-Agent: KMail/1.5.2
Cc: Rahul Karnik <rahul@genebrew.com>, lkml <linux-kernel@vger.kernel.org>,
       Laurens <masterpe@xs4all.nl>
References: <200307262309.20074.adq_dvb@lidskialf.net> <3F2477C4.2000105@pobox.com> <200307272011.51631.eu@marcelopenna.org>
In-Reply-To: <200307272011.51631.eu@marcelopenna.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307280953.34933.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 July 2003 00:11, Marcelo Penna Guerra wrote:
> No luck here, Jeff ... if the hardware is really based on AMD8111 as it
> appears to be (i2c and ide are similar), they surelly changed more
> registers. It'll take some time to RE it.

Hmm, If they had licensed it, I don't see why they would have changed the 
registers that much; they didn't for the other hardware they licensed. 
Judging by the size of nvnetlib.o, there isn't really that much to it (which 
is nice from an RE point of view)

