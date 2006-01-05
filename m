Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWAEXJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWAEXJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWAEXJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:09:25 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:43987 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932255AbWAEXJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:09:24 -0500
Subject: Re: Oops with 2.6.15
From: Lee Revell <rlrevell@joe-job.com>
To: Jacek Luczak <difrost@pin.if.uz.zgora.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43BDA76F.1000906@pin.if.uz.zgora.pl>
References: <43BDA76F.1000906@pin.if.uz.zgora.pl>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 18:09:21 -0500
Message-Id: <1136502562.847.75.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 00:10 +0100, Jacek Luczak wrote:
> Jan  5 19:25:04 slawek kernel: EIP:    0060:[<c0138603>]    Tainted:
> P 
>      VLI 

It's impossible to debug this unless you can reproduce it with a clean
kernel.  If you can't then it's likely that the binary kernel module is
the problem.

Lee

