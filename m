Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbUBUTBT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 14:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUBUTBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 14:01:19 -0500
Received: from quechua.inka.de ([193.197.184.2]:52952 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261608AbUBUTBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 14:01:18 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: dm-crypt, new IV and standards
Date: Sat, 21 Feb 2004 20:01:22 +0100
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2004.02.21.19.01.20.781478@dungeon.inka.de>
References: <20040220172237.GA9918@certainkey.com> <Xine.LNX.4.44.0402201624030.7335-100000@thoron.boston.redhat.com> <20040221164821.GA14723@certainkey.com>
To: linux-kernel@vger.kernel.org, Jean-Luc Cooke <jlcooke@certainkey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I know next to nothing about dm-crypt or crypt loop so far.

But I wonder: will it be possible to store some generic data in that place?
Password+Hash mechanism+Salt seemt to be pretty tied to passwords.

I would like it very much, if some rsa encrypted data could be stored instead,
so I can use a smart card with an rsa key to decrypt it.

Regards, Andreas

