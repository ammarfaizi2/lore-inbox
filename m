Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265533AbTFWVnH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 17:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266158AbTFWVnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 17:43:06 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:50150 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S265533AbTFWVmB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 17:42:01 -0400
From: root@mauve.demon.co.uk
Message-Id: <200306232156.WAA21810@mauve.demon.co.uk>
Subject: Re: usb memory pen broken since 2.5.72?
To: zyl@xs4all.nl (Lesley van Zijl)
Date: Mon, 23 Jun 2003 22:56:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200306232326.02007.zyl@xs4all.nl> from "Lesley van Zijl" at Jun 23, 2003 11:26:02 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> well bk1 was released a few minutes/hours ago, and there aren't any changes 
> for usb in there, so I'll wait for bk2 and fill in the bug report right away.
> 
> Ow another question what might be a bug or a poorly configured system,
> My mp3 player is a usb memory pen too, when i write to it, it can handle 
> 300/400 kbps, my other memory pen (a real one, so non-mp3) can only handle 
> 100kbps. is this a bug? or because of the vfat fs ?

It may simply be hardware limitations.
Generally extra write speed costs more (in terms of either design, or
actual components)

