Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270014AbTHJQ2h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 12:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270022AbTHJQ21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 12:28:27 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:53516 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S270014AbTHJQ2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 12:28:24 -0400
Date: Mon, 11 Aug 2003 02:28:08 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Pascal Brisset <pascal.brisset-ml@wanadoo.fr>
cc: Fruhwirth Clemens <clemens-dated-1061346967.29a4@endorphin.org>,
       <linux-kernel@vger.kernel.org>, <mbligh@aracnet.com>,
       <kernel@gozer.org>, <axboe@suse.de>
Subject: Re: [PATCH] loop: fixing cryptoloop troubles.
In-Reply-To: <20030810160706.5D083400211@mwinf0501.wanadoo.fr>
Message-ID: <Mutt.LNX.4.44.0308110226530.8288-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Aug 2003, Pascal Brisset wrote:

> But I'd rather see a semantically correct reference implementation.

Ok, please take into account the case where src == dst.


- James
-- 
James Morris
<jmorris@intercode.com.au>

