Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265038AbTHXJ6R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 05:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264820AbTHXJ6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 05:58:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:47805 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265038AbTHXJ6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 05:58:15 -0400
Date: Sun, 24 Aug 2003 03:00:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: parport_pc Oops with 2.6.0-test3
Message-Id: <20030824030043.729a5786.akpm@osdl.org>
In-Reply-To: <3F40B665.2010407@g-house.de>
References: <3F40B665.2010407@g-house.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kujau <evil@g-house.de> wrote:
>
> as the subject might presume, the parport_pc modules oopses when it's 
>  unloaded.

Can you retest on 2.6.0-test4?
