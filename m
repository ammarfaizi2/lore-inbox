Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVBCBTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVBCBTK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 20:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVBCBOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 20:14:52 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:29937 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262507AbVBCBEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 20:04:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KasmymrMnfsqjVpqoww1WtLz9J8+8BuMYx8OVVQrsbzzCmHtDUrBW02lpryfP0sHbI17ngvsU4zHLZ8xZHl9vXdOw87Qii8Elu8wLo5DcKEJ3Hj7jgrOwdykkxTD2ymZOv4Sxiqy6GB0MBvMJrar71aoDw8SDSoXq+DUP5xmgMo=
Message-ID: <58cb370e050202170352d73393@mail.gmail.com>
Date: Thu, 3 Feb 2005 02:03:59 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 0/29] ide: driver updates
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 11:40:17 +0900, Tejun Heo <tj@home-tj.org> wrote:
>  Hello, B. Zolnierkiewicz.

Hi,
 
>  These patches are various fixes/improvements to the ide driver.  They
> are against the 2.6 bk tree as of today (20050202).

Nice series.  As you probably already know I merged most
of the easy stuff.  I will comment on the real stuff soon.

Thanks,
Bartlomiej
