Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbTI1K4E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 06:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTI1K4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 06:56:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19121 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262538AbTI1K4B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 06:56:01 -0400
Message-ID: <3F76BE35.9060007@pobox.com>
Date: Sun, 28 Sep 2003 06:55:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [WIRELESS] Added probe declaration in arlan-main.c
References: <20030928101013.GA11057@gondor.apana.org.au>
In-Reply-To: <20030928101013.GA11057@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> Hi:
> 
> The declaration for probe got lost in the move from arlan to arlan-main.
> This patch puts it back.


The patch puts it back in the wrong place, though... :)

Linus, proper change headed your way in a few hours...

	Jeff



