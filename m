Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262733AbVCJQq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbVCJQq0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVCJQqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:46:25 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:2960 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262733AbVCJQpp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:45:45 -0500
Subject: Re: [PATCH] make st seekable again
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Kai Makisara <Kai.Makisara@kolumbus.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1110456640.6291.79.camel@laptopd505.fenrus.org>
References: <Pine.LNX.3.96.1050310064102.10287B-100000@gatekeeper.tmr.com>
	 <1110456640.6291.79.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110473019.28860.296.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 10 Mar 2005 16:43:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-03-10 at 12:10, Arjan van de Ven wrote:
> CONFIG_SECURITY_HOLES doesn't make sense.
> Better to just fix the security holes instead.

In the case of st its merely broken. I reviewed the code again to double
check for Marcelo. Still should be a "ask your vendor to fix tar" item.

Alan

