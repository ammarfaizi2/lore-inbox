Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTJTTys (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 15:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTJTTys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 15:54:48 -0400
Received: from mail.ccur.com ([208.248.32.212]:15883 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S262740AbTJTTys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 15:54:48 -0400
Subject: Is there a kgdb for Opteron for linux-2.6?
From: Jim Houston <jim.houston@ccur.com>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Concurrent Computer Corp.
Message-Id: <1066678923.1007.164.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 20 Oct 2003 15:42:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

I found your kgdb for x86_64 for linux-2.4.20 and I'm wondering if 
there is a version for the 2.6 tree?

If it doesn't exist, I'm thinking of merging your changes with the
current i386 kgdb from Andrew Morton's tree.

Jim Houston - Concurrent Computer Corp.

