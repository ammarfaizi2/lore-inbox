Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275262AbTHMQnA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 12:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275264AbTHMQnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 12:43:00 -0400
Received: from hera.cwi.nl ([192.16.191.8]:22495 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S275262AbTHMQm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 12:42:59 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 13 Aug 2003 18:42:56 +0200 (MEST)
Message-Id: <UTC200308131642.h7DGguT29620.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, davidsen@tmr.com
Subject: Re: 2.6.0-test2+Util-linux/cryptoapi
Cc: fvw@var.cx, linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I hope we can get the control of key length back

Maybe you didnt see earlier mail about this.

Look: half a year ago there was nothing in vanilla kernel and
util-linux, and one had to use outside patches. Today there
is some support in vanilla kernel and util-linux, but nobody
stops you from continued use of outside patches.

In case you would prefer kernel and util-linux to improve,
don't say "I want improvements", but say very precisely
what syntax you would prefer and why.
Think first about things mounted from /etc/fstab.
Implementing stuff is trivial, but after things have been
implemented they won't be changed, so it is better to do
things right at once.
