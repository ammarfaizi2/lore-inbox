Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUCFIcz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 03:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbUCFIcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 03:32:55 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:32839 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261610AbUCFIcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 03:32:54 -0500
To: Bjoern Schmidt <lucky21@uni-paderborn.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Badness in pci_find_subsys at drivers/pci/search.c:167
References: <40498A7F.5070306@uni-paderborn.de>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 06 Mar 2004 00:32:51 -0800
In-Reply-To: <40498A7F.5070306@uni-paderborn.de>
Message-ID: <521xo6xtn0.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Mar 2004 08:32:51.0647 (UTC) FILETIME=[9D2074F0:01C40355]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bjoern> Is there a possibility to find out which device caused
    Bjoern> this error?  It's the first time that it has been
    Bjoern> arisen...  The kernels version is v2.6.3, do you need more
    Bjoern> "input"?

This is caused by the closed source nvidia driver.  Only nvidia can
debug this problem.

 - Roland
