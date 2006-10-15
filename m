Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWJOXex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWJOXex (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 19:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWJOXex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 19:34:53 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:27293 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932214AbWJOXew
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 19:34:52 -0400
Subject: Re: [PATCH 4/4] bnep endianness bug: filtering by packet type
From: Marcel Holtmann <marcel@holtmann.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061015213125.GU29920@ftp.linux.org.uk>
References: <20061015213125.GU29920@ftp.linux.org.uk>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 01:34:13 +0200
Message-Id: <1160955253.14340.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

> <= and => don't work well on net-endian...

can we have a clean one for the BNEP part. Not one that changes
something and then another one reverting it.

Regards

Marcel


