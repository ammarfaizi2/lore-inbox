Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbUC3L70 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 06:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbUC3L70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 06:59:26 -0500
Received: from nefty.hu ([195.70.37.175]:63115 "EHLO nefty.hu")
	by vger.kernel.org with ESMTP id S263620AbUC3L7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 06:59:25 -0500
Date: Tue, 30 Mar 2004 13:59:21 +0200
From: Zoltan NAGY <nagyz@nefty.hu>
X-Mailer: The Bat! (v2.04.7) UNREG / CD5BF9353B3B7091
Reply-To: Zoltan NAGY <nagyz@nefty.hu>
Organization: Nefty Informatics
X-Priority: 3 (Normal)
Message-ID: <25313331.20040330135921@nefty.hu>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: pdflush and dm-crypt
In-Reply-To: <20040329150137.GH24370@suse.de>
References: <1067885681.20040329165002@nefty.hu>
 <20040329150137.GH24370@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jens,

> Try the -mm kernels intead, should have lots better behaviour for
> pdflush/dm interactions.

allright. with -mm5 it is _much_ better. load is back to normal. I
suppose we should get all this stuff into mainline ASAP ;) I'm sure
lot of people are using this combo.

thanks for you help,

--
Zoltan NAGY,
Network Administrator



