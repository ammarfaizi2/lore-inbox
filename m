Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267064AbTGKXal (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 19:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267091AbTGKXal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 19:30:41 -0400
Received: from [62.75.136.201] ([62.75.136.201]:48776 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S267064AbTGKXak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 19:30:40 -0400
Message-ID: <3F0F4C10.9050204@g-house.de>
Date: Sat, 12 Jul 2003 01:45:20 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: gcc-3.3.1 breaks kernel
References: <8avk.6lp.3@gated-at.bofh.it>
In-Reply-To: <8avk.6lp.3@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> Hi all...
> 
> Any brave soul there is using a prerelease of gcc-3.3.1 to build kernels ?
> (don't know if RawHide or SuSE beta or any other have that, apart from
> MandrakeCooker).

yes, 2.4.2x and 2.5.7x build properly with Debians gcc-3.3.1 here (x86).

> I have tried both with 22-pre2 and 22-pre4 and both hang. They
> can not start /sbin/init (or at least hang there). Once I got to
> a bash prompt with init=/bin/bash, and ls listed everything _twice_ and
> then hung.

console problems? are other gcc versions affected too?

Christian
-- 
BOFH excuse #75:

There isn't any problem

