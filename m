Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbRF1Guc>; Thu, 28 Jun 2001 02:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265571AbRF1GuW>; Thu, 28 Jun 2001 02:50:22 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:8459 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265570AbRF1GuM>; Thu, 28 Jun 2001 02:50:12 -0400
Date: Thu, 28 Jun 2001 03:34:06 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Zou Pengcheng <zoupch@necas.nec.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/scsi missing on 2.4.2
Message-ID: <20010628033406.Y3514@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Zou Pengcheng <zoupch@necas.nec.co.jp>, linux-kernel@vger.kernel.org
In-Reply-To: <3B3ACF60.2186FB7B@necas.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3B3ACF60.2186FB7B@necas.nec.co.jp>; from zoupch@necas.nec.co.jp on Thu, Jun 28, 2001 at 02:32:00PM +0800
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 28, 2001 at 02:32:00PM +0800, Zou Pengcheng escreveu:
> hi,
> 
> i cannot find the directory /proc/scsi on my redhat7.1 box (using kernel 2.4.2). i dont have scsi device on this system.
> 
> for 2.2.x, /proc/scsi is always there no matter i really have scsi device or not.
> 
> wonder why.

Maybe RH compiled the base support for SCSI statically for 2.2 kernels and
now they use it as modules?

- Arnaldo
