Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274816AbTGaQ6V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 12:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274819AbTGaQ6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 12:58:21 -0400
Received: from imh.informatik.uni-bremen.de ([134.102.224.4]:12016 "EHLO
	imh.informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id S274816AbTGaQ6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 12:58:20 -0400
To: linux-kernel@vger.kernel.org
From: Moritz Muehlenhoff <jmm@informatik.uni-bremen.de>
Subject: Re: [PATCH] O11int for interactivity
In-Reply-To: <200307301038.49869.kernel@kolivas.org>
References: <200307301038.49869.kernel@kolivas.org>
Date: Thu, 31 Jul 2003 18:58:15 +0200
Message-Id: <E19iGkp-0007xf-00@regenbogen.informatik.uni-bremen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In stuga.ml.linux.kernel, you wrote:
> _All_ testing and comments are desired and appreciated.

Playing "Baldurs Gate II" in winex in plain 2.6.0-test2 and
all tested 2.5 kernels before lead to heavy audio stutters
and 100% CPU consumption, while with 2.4 it consumes about
70%.

O11.1 on top of 2.6.0-test2 fixes that problem, it does now
behave just like 2.4. Thanks a lot.

Cheers,
        Moritz
