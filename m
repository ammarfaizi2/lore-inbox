Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315372AbSGYOtv>; Thu, 25 Jul 2002 10:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSGYOtv>; Thu, 25 Jul 2002 10:49:51 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:19698 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S315372AbSGYOtu>; Thu, 25 Jul 2002 10:49:50 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3D3FA130.6020701@snapgear.com> 
References: <3D3FA130.6020701@snapgear.com> 
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: uClinux (MMU-less) patches against 2.5.28 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 25 Jul 2002 15:52:47 +0100
Message-ID: <9309.1027608767@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gerg@snapgear.com said:
>  A new set of uClinux (MMU-less) patches agains 2.5.28. You can get it
> at:

> http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.28uc0.patch.gz 

Perhaps drop drivers/block/blkmem.c or justify reinventing the wheel?

--
dwmw2


