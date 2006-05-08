Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWEHLWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWEHLWO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 07:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWEHLWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 07:22:14 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:16589 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751260AbWEHLWN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 07:22:13 -0400
Subject: Re: sd-io CTO error - advice
From: Marcel Holtmann <marcel@holtmann.org>
To: Ram <vshrirama@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8bf247760605060337q7c6a3bay94f1ff86d482ffb1@mail.gmail.com>
References: <8bf247760605060337q7c6a3bay94f1ff86d482ffb1@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 08 May 2006 13:23:30 +0200
Message-Id: <1147087410.18554.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>   I am using OMAP.
> 
>   I am  trying to extend sd card driver in linux to support sdio.
> 
>   When i send CMD 5 - i get CTO error . i dont know whats the problem?.
> 
>    if i do enable MMC_DEBUG prints i do get the response sometimes.
> 
>    I dont know why the response is not consitent. add some printks it
> works sometimes. remove them it does not work.
> 
>    I tried sending CMD 5 in a loop - most of the time i do get CTO Errors?.

if you post your changes to the source, I am happy to test them with
SDHCI controller hardware and see how it works there.

Regards

Marcel


