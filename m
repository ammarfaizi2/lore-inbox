Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290866AbSARXIs>; Fri, 18 Jan 2002 18:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290865AbSARXIk>; Fri, 18 Jan 2002 18:08:40 -0500
Received: from zero.tech9.net ([209.61.188.187]:17928 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290869AbSARXH2>;
	Fri, 18 Jan 2002 18:07:28 -0500
Subject: Re: ext3-2.4-0.9.16
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C3E7F89.AB2F629@zip.com.au>
In-Reply-To: <3C3E7F89.AB2F629@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 18 Jan 2002 18:10:29 -0500
Message-Id: <1011395469.850.8.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-11 at 01:00, Andrew Morton wrote:
> A small ext3 update.  It fixes a few hard-to-hit but potentially
> serious problems.  The patch is against 2.4.18-pre3, and is also
> applicable to 2.4.17.

I didn't see any feedback so I wanted to confirm success on my
2.4.18-pre4 UP machine.  Survived prolonged use and some initial
stressing.  Good job.

	Robert Love

