Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263056AbUK0CGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbUK0CGz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUK0CGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:06:37 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262962AbUKZTiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:38:02 -0500
Subject: Re: ITE8212 - iteraid inclusion | general ide raid question
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041120144617.GB2286@schottelius.org>
References: <20041120144617.GB2286@schottelius.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101338626.2571.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 24 Nov 2004 23:23:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-11-20 at 14:46, Nico Schottelius wrote:
> I am wondering, whether support for the ide atapi (raid/normal)
> controllers will be merged into 2.6?

It's supported in 2.6.9-ac, as an IDE device. For 2.6.x it appears it
will be 2.6.11 or later as it waits on core changes.


