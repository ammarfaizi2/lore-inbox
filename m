Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbTDONoF (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 09:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbTDONoE 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 09:44:04 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.26]:46904 "EHLO
	mwinf0501.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261412AbTDONoE (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 09:44:04 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Jens Axboe <axboe@suse.de>
Subject: Re: BUGed to death
Date: Tue, 15 Apr 2003 15:55:35 +0200
User-Agent: KMail/1.5.1
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <80690000.1050351598@flay> <200304151401.00704.baldrick@wanadoo.fr> <20030415123134.GM9776@suse.de>
In-Reply-To: <20030415123134.GM9776@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304151555.36156.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you do that, you must audit every single BUG_ON to make sure the
> expression doesn't have any side effects.
>
> 	BUG_ON(do_the_good_stuff());

Good point, but easily dealt with (see other posts).

All the best,

Duncan.
