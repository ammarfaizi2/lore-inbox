Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbVINW43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbVINW43 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbVINW43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:56:29 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:18108 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S965089AbVINW43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:56:29 -0400
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
In-Reply-To: <4328425C.10803@tmr.com>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org> <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org> <4328425C.10803@tmr.com>
Date: Wed, 14 Sep 2005 23:56:27 +0100
Message-Id: <E1EFgB1-00015L-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> wrote:

> And is the Centrino "modem" now working? Or just the wireless?

There is no Centrino modem, as such. Vendors can put a variety of codecs
on the board. Most of them are supported with the snd-intel8x0m driver
and the (closed) slmodem userspace binary, but Conexant ones (as used by
IBM) require binary drivers from Linuxant.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
