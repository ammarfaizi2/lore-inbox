Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291689AbSBTIfL>; Wed, 20 Feb 2002 03:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291693AbSBTIfC>; Wed, 20 Feb 2002 03:35:02 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:50163 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S291689AbSBTIe5>; Wed, 20 Feb 2002 03:34:57 -0500
Message-ID: <3C735FB0.BF6F5FCD@redhat.com>
Date: Wed, 20 Feb 2002 08:34:56 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-26beta.16smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Giacomo Catenazzi <cate@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: NVidia driver with 2.5
In-Reply-To: <fa.fhm0v6v.d02k8d@ifi.uio.no> <3C735D97.70809@debian.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Put explicity that your code is GPL, so that we can use it
> (private use we can link with all code), but nvidia cannot
> use your work unless they release the source.

Since the nvidia driver is not gpl in the first place, the patch
is most likely in violation of nvidia's license already. Maybe they
let it go but... if they were mean and evil they could sue the guy
who posted the patch in the first place.
