Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279103AbRJ2KQ5>; Mon, 29 Oct 2001 05:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279124AbRJ2KQr>; Mon, 29 Oct 2001 05:16:47 -0500
Received: from t2.redhat.com ([199.183.24.243]:34290 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S279103AbRJ2KQ1>; Mon, 29 Oct 2001 05:16:27 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E15xVcA-0003bG-00@the-village.bc.nu> 
In-Reply-To: <E15xVcA-0003bG-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: adilger@turbolabs.com (Andreas Dilger), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
Subject: Re: Non-standard MODULE_LICENSEs in 2.4.13-ac2 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Oct 2001 10:16:21 +0000
Message-ID: <26434.1004350581@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  "BSD" can indicate totally closed source material as well as other
> stuff 

"GPL" can indicate modules which are either for internal use only and not
distributed, or which are distributed only to paying customers and shipped
with source, but the source is not publicly available.

Should we make the licence string "GPL" taint the kernel too, unless it's
explicitly stated that the source is available?

--
dwmw2


