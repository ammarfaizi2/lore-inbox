Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWIDNGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWIDNGE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWIDNGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:06:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:20657 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964902AbWIDNGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:06:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BGnTEm160LK2THe13H61YMoKUj3BHXsAHujZ6xdq+CLLKfHDPv9i1GPaoZd2EbP/6PcbYiQvEvR0f39rQKJylXjvHisjO0UsaRNXBE8LM0mIhUQP6LrzJFQ8HZzjS3gbjrVk+XdJ0AzkLKeiOy/pV5LDn2/o5DOjqgOa30UIXyc=
Message-ID: <625fc13d0609040605o313f3910yca80cb29b76ebc60@mail.gmail.com>
Date: Mon, 4 Sep 2006 08:05:59 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: Aubrey <aubreylee@gmail.com>
Subject: Re: [PATCH] Fill more device IDS in the structure of m25p80 driver
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <6d6a94c50609040146k3538ef21x2a6d426f344f1e2e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50609040146k3538ef21x2a6d426f344f1e2e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/06, Aubrey <aubreylee@gmail.com> wrote:
> Hi all,
>
> the structure:
> struct flash_info __devinitdata m25p_data [] = {
> /* REVISIT: fill in JEDEC ids, for parts that have them */
> ...
> };
>
> has a bunch of missing fields (like the JEDEC ids indicated) ... this
> causes problems when actually trying to use some ST parts as it gets
> detected incorrectly
>
> The following is the patch.

The patch appears to have corrupted whitespace.  Your mailer probably
mangled it.  Care to try and fix it and resend?

thx,
josh
