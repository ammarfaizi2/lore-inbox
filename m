Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbUC0L3w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 06:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbUC0L3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 06:29:52 -0500
Received: from [217.73.129.129] ([217.73.129.129]:23191 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S261686AbUC0L3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 06:29:51 -0500
Date: Sat, 27 Mar 2004 13:28:44 +0200
Message-Id: <200403271128.i2RBSiTd162082@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: reiserfs oops
To: wakko@animx.eu.org, linux-kernel@vger.kernel.org
References: <20040326204012.A1682@animx.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner <wakko@animx.eu.org> wrote:
WW> Kernel vanilla 2.6.4 with cdrw packet writing patch.

WW> kernel BUG at fs/reiserfs/prints.c:339!
WW> invalid operand: 0000 [#1]

There was extra line in your kernel log just prior to those two,
what was it saying?

Bye,
    Oleg
