Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbTLRFhS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 00:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264938AbTLRFhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 00:37:18 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:62610 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264937AbTLRFhR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 00:37:17 -0500
Message-ID: <3FE13D07.6080204@cyberone.com.au>
Date: Thu, 18 Dec 2003 16:37:11 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Joe Pranevich <jpranevich@kniggit.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Wonderful World of Linux 2.6 - Final
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll just mention that the "Hyperthreading" section is not entirely
accurate: the process scheduler is blissfully unaware of HT / SMT
presently. It is a must fix item though, and there are a number of
different implementations available to solve this.

I expect something will be merged before too long.

Nick

