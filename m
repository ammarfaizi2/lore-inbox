Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316363AbSEOKIy>; Wed, 15 May 2002 06:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316364AbSEOKIx>; Wed, 15 May 2002 06:08:53 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:21745 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316363AbSEOKIx>; Wed, 15 May 2002 06:08:53 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1021396159.823.59.camel@sinai> 
To: Robert Love <rml@tech9.net>
Cc: blenderman@wanadoo.be, linux-kernel@vger.kernel.org
Subject: Re: SMP doc problem 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 May 2002 11:08:36 +0100
Message-ID: <1306.1021457316@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rml@tech9.net said:
>  Just add it.  Or do `MAKE="make -jN" make whatever" 

Just using 'make -j3' when building the kernel should suffice, with recent 
versions of make.

--
dwmw2


