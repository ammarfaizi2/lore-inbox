Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269718AbRHMCBs>; Sun, 12 Aug 2001 22:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269712AbRHMCBi>; Sun, 12 Aug 2001 22:01:38 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:19219 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269698AbRHMCB0> convert rfc822-to-8bit; Sun, 12 Aug 2001 22:01:26 -0400
Date: Sun, 12 Aug 2001 21:32:41 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 3-order allocation failed.
In-Reply-To: <20010812025810.A2972@telia.com>
Message-ID: <Pine.LNX.4.21.0108122132290.18092-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 12 Aug 2001, André Dahlqvist wrote:

> Hi guys,
> 
> With recent kernel, 2.4.7 and 2.4.8 my syslog file has been filled with
> these messages:
> 
> Aug 12 02:08:58 sledgehammer kernel: __alloc_pages: 3-order allocation failed.
> Aug 12 02:08:58 sledgehammer kernel: __alloc_pages: 2-order allocation failed.
> Aug 12 02:08:58 sledgehammer kernel: __alloc_pages: 1-order allocation failed.
> Aug 12 02:08:58 sledgehammer kernel: __alloc_pages: 3-order allocation failed.
> 
> I have not yet found a pattern for when it happens but it doesn't seam to
> affect my system all that much. Let me know if you want further info or if
> this is a known thing.

Are you using SCSI? 

