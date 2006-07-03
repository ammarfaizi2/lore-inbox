Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWGCKu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWGCKu1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 06:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWGCKu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 06:50:27 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:29512 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750790AbWGCKu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 06:50:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SuyTS2ZS0+L35Sgcw9jv2u4++MKvL3S2vvfjawEbEsfBAECksQ274izL48G2ZbcJUPriGoJnN5fYH8ha0TPmXB3ey5Nq/Uy4DmmL8tdyYHefkv054BBIUo5KvQ55I35isuYS4qqfbgqydwVXH68XqGw22Ar3CQhUfeHx0yKwNlQ=
Message-ID: <6bffcb0e0607030350l497fdeb9ucb924e883fdad29@mail.gmail.com>
Date: Mon, 3 Jul 2006 12:50:26 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-mm6
Cc: "Tigran Aivazian" <tigran@veritas.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060703030355.420c7155.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060703030355.420c7155.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/07/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/
>

Something is missing in drivers/base/firmware_class.c?

WARNING: /lib/modules/2.6.17-mm6/kernel/arch/i386/kernel/microcode.ko
needs unknown symbol release_firmware
WARNING: /lib/modules/2.6.17-mm6/kernel/arch/i386/kernel/microcode.ko
needs unknown symbol request_firmware
WARNING: /lib/modules/2.6.17-mm6/kernel/arch/i386/kernel/microcode.ko
needs unknown symbol release_firmware
WARNING: /lib/modules/2.6.17-mm6/kernel/arch/i386/kernel/microcode.ko
needs unknown symbol request_firmware

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
