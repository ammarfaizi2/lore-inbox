Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288862AbSAIRgg>; Wed, 9 Jan 2002 12:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288845AbSAIRg0>; Wed, 9 Jan 2002 12:36:26 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:3087 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S288862AbSAIRgK>; Wed, 9 Jan 2002 12:36:10 -0500
Date: Wed, 9 Jan 2002 14:22:53 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Nathan Myers <ncm-nospam@cantrip.org>
Cc: linux-kernel@vger.kernel.org, deischen@iworks.InterWorks.org
Subject: Re: bad patch in aic7xxx_linux.c
In-Reply-To: <20020109090628.A18526@cantrip.org>
Message-ID: <Pine.LNX.4.21.0201091421560.21034-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Jan 2002, Nathan Myers wrote:

> Marcelo,
> 
> In patch-2.4.17-pre2, a nonsensical change was made in 
> linux/drivers/scsi/aic7xxx/aic7xxx_linux.c .  While apparently 
> harmless, it suggests to me that you had intended to fold in an 
> entirely different patch, and "missed".
> 
> I don't find a current maintainer for aic7xxx listed in MAINTAINERS.

Its not nonsensical: It fixes a critical bug as David pointed out.


