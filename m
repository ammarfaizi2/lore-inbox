Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVACQ4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVACQ4n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 11:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVACQ4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 11:56:43 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:25008 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261498AbVACQ4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 11:56:40 -0500
Subject: Re: 2.6.10-ac2 - more cdrecord wierdness
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel M/L <linux-kernel@vger.kernel.org>
In-Reply-To: <41D8C55A.5010801@tmr.com>
References: <41D8C55A.5010801@tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104765568.12780.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 03 Jan 2005 15:52:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-03 at 04:08, Bill Davidsen wrote:
> Just a FYI - I assume there's a good reason why reading the unclosed 
> filesystem size would compromise security.

It may just be an oversight in the built in list of "safe" commands. Do
you know what command is being rejected ? 

