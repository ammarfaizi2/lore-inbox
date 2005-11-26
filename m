Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVKZXMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVKZXMf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 18:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVKZXMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 18:12:35 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:42711 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750780AbVKZXMe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 18:12:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EgliJbw7sgtHpvlQua8vdaMMrmeTwBxdl7KNxTlUxy6oEpxIZ3LcHvLAM6rFfrsxwTbVx8U4jmm6RGh4OPv1o6NBkg3FML/oihHVrFhtY4g9ECs0d+BLLdbYcxusQHZF91vb3KaBy0YffRCccaIDct0bdUdMNhQqBzmGAKKg9i4=
Message-ID: <29495f1d0511261512x4ac3387ag3f9d9fe5360b19c2@mail.gmail.com>
Date: Sat, 26 Nov 2005 15:12:34 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: David Brown <dmlb2000@gmail.com>
Subject: Re: linux-2.6.14.tar.bz2 permissions
Cc: mhf@users.berlios.de, linux-kernel@vger.kernel.org
In-Reply-To: <9c21eeae0511261441j7e4cc7c7ya99daaf1e437cb2a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com>
	 <200511262319.15042.norbert-kernel@hipersonik.com>
	 <9c21eeae0511261427ld8375bfi1c838b56cab426fb@mail.gmail.com>
	 <20051126223921.E7EF31AC3@hornet.berlios.de>
	 <9c21eeae0511261441j7e4cc7c7ya99daaf1e437cb2a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/05, David Brown <dmlb2000@gmail.com> wrote:
> > Check your umask and set it to 022 ;)
>
> it is, still comes up world read/write.

Does using --no-same-permissions help when untarring?

Thanks,
Nish
