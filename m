Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbTKJJzZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 04:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTKJJzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 04:55:25 -0500
Received: from [212.86.245.254] ([212.86.245.254]:26752 "EHLO umka.bear.com.ua")
	by vger.kernel.org with ESMTP id S263102AbTKJJzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 04:55:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Alex Lyashkov <shadow@itt.net.ru>
Organization: Home
To: Alex Tomas <bzzz@bzzz.linuxhacker.ru>
Subject: Re: [BUG] journal handler reference count breaked and fs deadlocked
Date: Mon, 10 Nov 2003 11:55:14 +0200
User-Agent: KMail/1.4.1
References: <200311092334.01957.shadow@itt.net.ru> <20031110121225.19daf448.bzzz@bzzz.linuxhacker.ru>
In-Reply-To: <20031110121225.19daf448.bzzz@bzzz.linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200311101155.16151.shadow@itt.net.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 November 2003 11:12, Alex Tomas wrote:
> what system did that time? mount options?
see my last message.
at one console - start/stop services
at second console - mount -o remount,usrquota,grpquota / (for only test 
syncfs)

-- 
With best regards,
Alex
