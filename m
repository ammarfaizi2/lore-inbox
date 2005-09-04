Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbVIEQ3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVIEQ3q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVIEQ3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:29:46 -0400
Received: from [81.2.110.250] ([81.2.110.250]:59285 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932328AbVIEQ3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:29:45 -0400
Subject: re: RFC: i386: kill !4KSTACKS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org, vda@ilport.com.ua
In-Reply-To: <20050904145129.53730.qmail@web50202.mail.yahoo.com>
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 04 Sep 2005 18:19:57 +0100
Message-Id: <1125854398.23858.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-09-04 at 07:51 -0700, Alex Davis wrote:
> I'm not asking you to debug crashes. I'm simply requesting that the
> kernel stack size situation remain as it is: with 8K as the default
> and 4K configurable. 

How about the relevant question - why hasn't someone fixed ndiswrapper
yet - its been pending for months.

