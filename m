Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161264AbWJ3LSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161264AbWJ3LSM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 06:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161266AbWJ3LSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 06:18:11 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:31977 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1161264AbWJ3LSJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 06:18:09 -0500
Subject: Re: [PATCH] bnep endianness bug: filtering by packet type
From: Marcel Holtmann <marcel@holtmann.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <E1GeUVt-0002WO-SH@ZenIV.linux.org.uk>
References: <E1GeUVt-0002WO-SH@ZenIV.linux.org.uk>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 12:17:58 +0100
Message-Id: <1162207078.24333.48.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

> <= and => don't work well on net-endian...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


