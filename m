Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315708AbSFYRGK>; Tue, 25 Jun 2002 13:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSFYRFO>; Tue, 25 Jun 2002 13:05:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60422 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315708AbSFYRFM>;
	Tue, 25 Jun 2002 13:05:12 -0400
Message-ID: <3D18A27C.F96BF474@zip.com.au>
Date: Tue, 25 Jun 2002 10:03:56 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rvandijk@science.uva.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: buffer layer error in 2.5.24
References: <20020624214812Z315334-22020+10139@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudmer van Dijk wrote:
> 
> Hi,
> 
> 2.5.24 with 2.5.24-kg3 applied
> 
> got this error:
> buffer layer error at page-writeback.c:524

What filesystems are you using there?  tmpfs?
