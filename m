Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270433AbRHHJdi>; Wed, 8 Aug 2001 05:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270434AbRHHJd2>; Wed, 8 Aug 2001 05:33:28 -0400
Received: from [212.17.18.2] ([212.17.18.2]:5893 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id <S270433AbRHHJdW> convert rfc822-to-8bit;
	Wed, 8 Aug 2001 05:33:22 -0400
Message-Id: <200108080934.f789YBG22575@gw.ac-sw.com>
Content-Type: text/plain; charset=US-ASCII
From: Stepan Kalichkin <step@ac-sw.com>
Organization: NGTS
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7-ac8
Date: Wed, 8 Aug 2001 16:34:15 +0700
X-Mailer: KMail [version 1.2.9]
In-Reply-To: <3B702554.16946D46@mediaone.net>
In-Reply-To: <3B702554.16946D46@mediaone.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's was strange for me too.
compiled ac8 kernel seems as ac7 everywhere

On Wednesday 08 August 2001 00:28, Dr. Andrew L. Blais wrote:
> My humble guess is that
>
> -EXTRAVERSION =
> +EXTRAVERSION = -ac7
>
> wants to be:
>
> -EXTRAVERSION =
> +EXTRAVERSION = -ac8
>
> >>> Doc Alb
