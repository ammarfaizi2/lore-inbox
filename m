Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWACQwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWACQwY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 11:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWACQwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 11:52:23 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:9371 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751470AbWACQwA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 11:52:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SEAavKYt+4HdtEgr4i1q3PJLcwqSaihTuTtdY2Are02ts/vLmvZaTpSAkG9NwFxptcz+K+4KiKdnTEhbPFZCXlPXgHNtkjCzNOHxCwek2TQwMLFRG6yqlR0pSCxh3F0hb2k83Iu/YawoUUa7RDMr167jBjJlOku74lVGU+KKVKo=
Message-ID: <58cb370e0601030851w62fc917bibe0fd5069b2f3e44@mail.gmail.com>
Date: Tue, 3 Jan 2006 17:51:57 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [git patches] 2.6.x libata updates
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060103164319.GA402@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060103164319.GA402@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/06, Jeff Garzik <jgarzik@pobox.com> wrote:

> --- a/drivers/scsi/ata_piix.c
> +++ b/drivers/scsi/ata_piix.c

> + * with SITRE and the 0x44 timing register). See pata_oldpiix and pata_mpiix
> + * for the early chip drivers.

pata_oldpiix and pata_mpiix are not in the mainline
