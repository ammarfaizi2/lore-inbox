Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263789AbUDOQSX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 12:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbUDOQSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 12:18:22 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:22509 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264122AbUDOQST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 12:18:19 -0400
Subject: Re: [PATCH] fix 4k irqstacks on x86 (and add voyager support)
From: James Bottomley <James.Bottomley@steeleye.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0404151139190.10471@montezuma.fsmlabs.com>
References: <1082042268.2166.2.camel@mulgrave> 
	<Pine.LNX.4.58.0404151126090.10471@montezuma.fsmlabs.com>
	<1082043207.1804.4.camel@mulgrave> 
	<Pine.LNX.4.58.0404151139190.10471@montezuma.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 15 Apr 2004 11:18:05 -0500
Message-Id: <1082045886.1804.6.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-15 at 11:16, Zwane Mwaikambo wrote:
> Sorry for being a bit slow here, doesn't this affect voyager at all?

No.  Voyager has a separate smp implementation.

James


