Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285408AbRLGEqc>; Thu, 6 Dec 2001 23:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285409AbRLGEqW>; Thu, 6 Dec 2001 23:46:22 -0500
Received: from mail12.speakeasy.net ([216.254.0.212]:32392 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S285408AbRLGEqG>; Thu, 6 Dec 2001 23:46:06 -0500
Subject: 2.4.17-pre5 still not being nice with local symbols in discarded
	section .text.exit
From: safemode <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 06 Dec 2001 23:46:05 -0500
Message-Id: <1007700365.24879.0.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a kernel problem apparently, binutils is just enforcing it's
rules now instead of letting this slip by. A patch was submitted before
but hasn't been accepted it seems.  Is it available somewhere ? outside
list archives that is. 



