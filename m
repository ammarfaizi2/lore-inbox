Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286853AbRLWJs1>; Sun, 23 Dec 2001 04:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286854AbRLWJsR>; Sun, 23 Dec 2001 04:48:17 -0500
Received: from t2.redhat.com ([199.183.24.243]:4091 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S286853AbRLWJsF>; Sun, 23 Dec 2001 04:48:05 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <15395.39479.366221.613466@irving.iisd.sra.com> 
In-Reply-To: <15395.39479.366221.613466@irving.iisd.sra.com>  <20011220143247.A19377@thyrsus.com> <15394.29882.361540.200600@irving.iisd.sra.com> <20011220185226.A25080@thyrsus.com> <15395.33489.779730.767039@irving.iisd.sra.com> <20011221134034.B11147@thyrsus.com> 
To: David Garfield <garfield@irving.iisd.sra.com>
Cc: esr@thyrsus.com, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Dec 2001 09:47:58 +0000
Message-ID: <30475.1009100878@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


garfield@irving.iisd.sra.com said:
> 
>   If the machine has between 1 and 4 Gigabytes physical RAM, then
>   answer "4GB" here.
> Note "3GiB/1GiB" and "4GB".

That's because the config option is named like that, and wasn't corrected 
when the help text was. Maybe the following would be better:

   If the machine has between 1 and 4 Gigabytes physical RAM, then
   answer "4GB"(sic) here.


--
dwmw2


