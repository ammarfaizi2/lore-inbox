Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281533AbRKMGM3>; Tue, 13 Nov 2001 01:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281527AbRKMGMU>; Tue, 13 Nov 2001 01:12:20 -0500
Received: from 24-25-196-177.san.rr.com ([24.25.196.177]:25348 "HELO
	acmay.homeip.net") by vger.kernel.org with SMTP id <S281535AbRKMGMG>;
	Tue, 13 Nov 2001 01:12:06 -0500
Date: Mon, 12 Nov 2001 22:12:05 -0800
From: andrew may <acmay@acmay.homeip.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Changed message for GPLONLY symbols
Message-ID: <20011112221205.A6222@ecam.san.rr.com>
In-Reply-To: <10444.1005619809@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <10444.1005619809@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 01:50:09PM +1100, Keith Owens wrote:
> When insmod detects a non-GPL module with unresolved symbols it
> currently says:
> 
> Note: modules without a GPL compatible license cannot use GPLONLY_ symbols

I think you should point them towards lkml FAQ section and say that GPLONLY
symbols are rarely used but also a possible problem.
