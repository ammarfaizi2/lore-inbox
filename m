Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266796AbTA2TEm>; Wed, 29 Jan 2003 14:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266804AbTA2TEm>; Wed, 29 Jan 2003 14:04:42 -0500
Received: from [81.2.122.30] ([81.2.122.30]:7688 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266796AbTA2TEm>;
	Wed, 29 Jan 2003 14:04:42 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301291914.h0TJEhsa002226@darkstar.example.net>
Subject: Re: kernel.org frontpage
To: Valdis.Kletnieks@vt.edu
Date: Wed, 29 Jan 2003 19:14:43 +0000 (GMT)
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <200301291509.h0TF9S4K003537@turing-police.cc.vt.edu> from "Valdis.Kletnieks@vt.edu" at Jan 29, 2003 10:09:28 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > No, it would add absolutely nothing (other than clutter.)  All the .sign 
> > files are good for is to check for rogue mirrors.
> 
> Or a rogue *primary* site, as has already happened to OpenSSH and Sendmail.

I see what you mean, but I don't see how it makes it any less useful
to have them on the front page - if you download the latest kernel
patch from a mirror, you could then just click on the relevant link on
the front page of kernel.org - infact, as http access to kernel.org is
frequently much slower than ftp, it might actually be very useful,
because anybody downloading via http would make two requests, (OK,
about 7, because of the images on the front page), instead of about
13, if they traverse each directory to the .sign file.

John
