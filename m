Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbVJMLJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbVJMLJB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 07:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbVJMLJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 07:09:01 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:40094 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750963AbVJMLJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 07:09:00 -0400
Message-ID: <434E4041.7020203@arcor.de>
Date: Thu, 13 Oct 2005 13:08:49 +0200
From: Klaus Dittrich <kladit@arcor.de>
User-Agent: Mozilla Thunderbird 1.0.5 (X11/20050711)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc* / xinetd
References: <20051012143657.GA1625@xeon2.local.here> <200510121745.j9CHj6XE023497@turing-police.cc.vt.edu>            <434D5574.10405@arcor.de> <200510122013.j9CKDVGV032270@turing-police.cc.vt.edu>
In-Reply-To: <200510122013.j9CKDVGV032270@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This (service dgram_time, recvfrom: Bad address (errno = 14))
behavior of the kernel started with 2.6.14-rc2-git9.

I am not a kernel-guru and the log shows several net changes.
--
Klaus

