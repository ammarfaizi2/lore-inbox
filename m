Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265337AbUBFDTU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 22:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266071AbUBFDTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 22:19:20 -0500
Received: from firewall.conet.cz ([213.175.54.250]:16256 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265337AbUBFDTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 22:19:19 -0500
Message-ID: <402307B3.9070103@conet.cz>
Date: Fri, 06 Feb 2004 04:19:15 +0100
From: Libor Vanek <libor@conet.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel speed acording to selected CPU?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
did anybody done some benchmarking of kernel speed according to selected CPU? What I mean - if I have let's say P4, Athlon & VIA C3 and I compile kernel for generic Pentium class or compile it for each CPU separately what can be perfomance hit? 1%? 20%? 100%? ;) I know that it heavily depends on how much I spent in user/kernel space and usage (desktop/file server/database/...)


Thanks,
Libor
