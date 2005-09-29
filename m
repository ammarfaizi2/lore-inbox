Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVI2ADU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVI2ADU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 20:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVI2ADU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 20:03:20 -0400
Received: from [81.2.110.250] ([81.2.110.250]:24974 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751263AbVI2ADU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 20:03:20 -0400
Subject: Re: fat / multi arch binaries?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200509281918.56386.aj@dungeon.inka.de>
References: <200509281918.56386.aj@dungeon.inka.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 29 Sep 2005 01:30:33 +0100
Message-Id: <1127953833.29682.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> but I couldn't find anything whether
> such binaries would work with linux
> or not. can you tell me?

Linux doesn't. Instead there are a set of policies allowing parallel
library installations which although far from perfect do work.

If you want to put both architectures in one package then a simple
script to front it will do what is needed.

Alan

