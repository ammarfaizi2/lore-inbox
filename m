Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbTLAAQG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 19:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTLAAQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 19:16:06 -0500
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:62183 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262522AbTLAAQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 19:16:03 -0500
Date: Mon, 1 Dec 2003 01:16:02 +0100
From: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Bug with extraversion in kernel-2.4.23
Message-ID: <20031201011602.A12652@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1070229674.3fca68aaea488@webmail.tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1070229674.3fca68aaea488@webmail.tuxfamily.org>; from alexis@linuxcode.eu.org on Sun, Nov 30, 2003 at 11:01:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The extraversion variable of the Makefile is very badly interpreted.
> When the kernel is installed, I have 2 directory of modules :
> /lib/modules/2.4.23
> /lib/modules/2.4.23-fnux (my extraversion is -fnux)

No way. The directory without -fnux is probably just a leftover from previous
make modules_install. When you run 2.4.23-fnux, you won't need it.

Rudo.
