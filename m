Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263049AbUK0CxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263049AbUK0CxO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbUK0CEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:04:50 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262916AbUKZThz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:37:55 -0500
Subject: Re: Linux 2.6.9-ac11
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41A45F75.4060304@ttnet.net.tr>
References: <41A45F75.4060304@ttnet.net.tr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101400114.18357.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 25 Nov 2004 16:28:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-11-24 at 10:16, O.Sezer wrote:
> > o	Fix tiny ide-cd race				(Alan Cox)
> 
> Is this change not necessary for 2.4?

It might not be a bad idea to push it to 2.4 once its had a bit of time
in 2.6.x

