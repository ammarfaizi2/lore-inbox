Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWJ2S3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWJ2S3N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 13:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWJ2S3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 13:29:12 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:50836 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932357AbWJ2S3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 13:29:11 -0500
Subject: Re: loading EHCI_HCD slows down IDE disk performance by 50%
From: Lee Revell <rlrevell@joe-job.com>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <5a4c581d0610291013w40c1b0e6g408051a79534956a@mail.gmail.com>
References: <5a4c581d0610291013w40c1b0e6g408051a79534956a@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 29 Oct 2006 13:29:20 -0500
Message-Id: <1162146560.14733.65.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-29 at 19:13 +0100, Alessandro Suardi wrote:
> Any hints/tips about what to try with this issue will be
>  of course very welcome. 

git bisect

