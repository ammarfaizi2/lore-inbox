Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbULZSRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbULZSRP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 13:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbULZSRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 13:17:14 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:62104 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261721AbULZSRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 13:17:06 -0500
Subject: Re: [patch 6/6] delete unused file
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: domen@coderock.org
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041226153257.0F3501F126@trashy.coderock.org>
References: <20041226153257.0F3501F126@trashy.coderock.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104081178.15994.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Dec 2004 17:13:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-12-26 at 15:33, domen@coderock.org wrote:
> Remove nowhere referenced file. (egrep "filename\." didn't find anything)

This file is there for a reason - it completes the set of endian types
should anyone port to a mixed endian system.

