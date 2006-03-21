Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWCUHa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWCUHa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 02:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWCUHa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 02:30:58 -0500
Received: from pproxy.gmail.com ([64.233.166.182]:9052 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751231AbWCUHa6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 02:30:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LP9+LCs5JxYM8YSt2JhEGczYKGCSOWn6dX1iWgIkPXLN+WQZtaRHThUagecRu6Tl3yGUMXobP2uDayJFiuGIQ7aa5yK5Dyxkay9vh89puCyMOrST2o3jI5KpWkaGJhLhKildCcCB4gT1Gta4Bxrzg8OK7htnvJbjmkr/DOPNcNo=
Message-ID: <489ecd0c0603202330m647be15ap8df39c1e95ca8163@mail.gmail.com>
Date: Tue, 21 Mar 2006 15:30:57 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2]Blackfin archtecture patche for 2.6.16
In-Reply-To: <489ecd0c0603200200va747a68k187651930a3f0a51@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c0603200200va747a68k187651930a3f0a51@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   Anyone like to review this patch? Any comment or suggestion is
appreciated. If you have questions, send me mails.

   Thank you in advance!

Regards,
Luke Yang <luke.adi@gmail.com>

On 3/20/06, Luke Yang <luke.adi@gmail.com> wrote:
> Hi all,
>
>    This is the Blackfin archtecture patch for kernel 2.6.16.  This
> patch include header files and arch files, which are hard to split.
> Thus the patch size is big, I hope that is OK for a new architecture
> patch. For the other driver patches, I'll send them one by one in
> small size. Thanks!
>
>   Because of the big size, I put it here:
> http://blackfin.uclinux.org/frs/download.php/810/blackfin-arch.patch.tar.bz2
>
> Signed off by: Luke Yang <luke.adi@gmail.com>
>
> --
> Best regards,
> Luke Yang
> magic.yyang@gmail.com; luke.adi@gmail.com
>


--
Best regards,
Luke Yang
magic.yyang@gmail.com; luke.adi@gmail.com
