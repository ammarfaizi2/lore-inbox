Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbUKBOf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUKBOf6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 09:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbUKBOLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 09:11:48 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:7437 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261495AbUKBN4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 08:56:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DOhBFspcdxx57z0brD9M73Ki7983U4TzXzfz3wMUgcgrKUaxG+9/yHQba2Zi9QeR5OxHdqJ7MrsQ+USuaTciW/ihjOwsHTCvqfsywg4V9BFVnHBcUFN1Px0z4RWVATYO5NgEu4IjeOqsj9VbVBMueB71KPmrK8islZTn/RQA9iE=
Message-ID: <58cb370e04110205565c58d7bd@mail.gmail.com>
Date: Tue, 2 Nov 2004 14:56:26 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Mikael Starvik <mikael.starvik@axis.com>
Subject: Re: [PATCH 8/10] CRIS architecture update - Move drivers
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668014C748C@exmail1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <BFECAF9E178F144FAEF2BF4CE739C668014C748C@exmail1.se.axis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael,

could you rename Etrax IDE driver to something less confusing than ide.c
(ie. ide-etrax.c).

Thanks.

On Tue, 2 Nov 2004 14:04:51 +0100, Mikael Starvik
<mikael.starvik@axis.com> wrote:
> This is a shell script to move drivers from arch/cris/arch-v10/drivers to
> e.g. drivers/net/cris/v10. This must be applied after patch 1-7 and before
> patch 9.
> 
> Let me know if you prefer this as a big diff instead.
> 
> Signed-Off-By: starvik@axis.com
> 
> /Mikael
