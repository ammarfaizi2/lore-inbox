Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271736AbTG2N53 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271737AbTG2N52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:57:28 -0400
Received: from hera.cwi.nl ([192.16.191.8]:3769 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S271736AbTG2N50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:57:26 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 29 Jul 2003 15:56:24 +0200 (MEST)
Message-Id: <UTC200307291356.h6TDuOF15499.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, root@chaos.analogic.com
Subject: Re: Turning off automatic screen clanking
Cc: clepple@ghz.cc, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think you need to call poke_blanked_console() after setting

There is already an unblank subioctl of TIOCLINUX.
