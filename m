Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbUFFE0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUFFE0G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 00:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUFFE0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 00:26:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:11501 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262882AbUFFE0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 00:26:03 -0400
Date: Sat, 5 Jun 2004 21:25:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Clark <michael@metaparadigm.com>
Cc: kloska@scienion.de, hugh@veritas.com, Matt_Domsch@dell.com,
       linux-kernel@vger.kernel.org
Subject: Re: APM realy sucks on 2.6.x
Message-Id: <20040605212508.2f30eb59.akpm@osdl.org>
In-Reply-To: <40C28F9C.9050004@metaparadigm.com>
References: <Pine.LNX.4.44.0406050038120.2163-100000@localhost.localdomain>
	<40C2004A.8050706@scienion.de>
	<40C28F9C.9050004@metaparadigm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Clark <michael@metaparadigm.com> wrote:
>
> One possibility is code sections incorrectly marked as discardable.

`make buildcheck' will locate these.
