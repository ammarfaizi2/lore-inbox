Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVAXVrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVAXVrs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVAXVqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:46:35 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:25402 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261606AbVAXVnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:43:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DEQ5rG2MDfxBKkLIyffQ8jEMZt8RycYOTRHcqjstWXDl3SwKulXXl7+ZsRb3djs7q/HjnvTQeBzpaRtekyuNbY7R4uqEhUXCsjRYWN1tHLB1gdNxZNTC+dWTa67EYvzrYvng8h8JoYBY9faLtGrRon0Me37niLleyJfCAhd8NaQ=
Message-ID: <58cb370e05012413434a1a4935@mail.gmail.com>
Date: Mon, 24 Jan 2005 22:43:52 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jason Gaston <jason.d.gaston@intel.com>
Subject: Re: [PATCH] IDE driver support for Intel ICH4L - 2.6.11-rc1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200501240428.01794.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200501240428.01794.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 04:28:01 -0800, Jason Gaston
<jason.d.gaston@intel.com> wrote:
> This patch adds IDE driver support for ICH4-L to the piix.c, piix.h and pci_ids.h source.  This patch was build against 2.6.11-rc1.
> If acceptable, please apply.

Thanks but -bk already has support for ICH4-L (added 10 days ago).

Bartlomiej
