Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281118AbRKYVwa>; Sun, 25 Nov 2001 16:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281126AbRKYVwK>; Sun, 25 Nov 2001 16:52:10 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:30739 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281118AbRKYVwA>;
	Sun, 25 Nov 2001 16:52:00 -0500
Date: Sun, 25 Nov 2001 19:51:51 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: <Teodor.Iacob@astral.kappa.ro>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.16-pre1
Message-ID: <20011125195151.D1706@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	<Teodor.Iacob@astral.kappa.ro>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20011125145134.B23807@flint.arm.linux.org.uk> <Pine.LNX.4.31.0111252343030.14413-100000@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0111252343030.14413-100000@linux.kappa.ro>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Nov 25, 2001 at 11:44:11PM +0200, Teodor Iacob escreveu:
> Could someone tell if reiserfs or ext3 filesystems are affected by this?

AFAIK, yes, all filesystems with backing storage are affected.

- Arnaldo
