Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVADXVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVADXVu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVADXNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:13:15 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:28086 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262379AbVADXI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:08:28 -0500
Subject: Re: [PATCH] mm: overcommit updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andries.Brouwer@cwi.nl
In-Reply-To: <m14qhxmkw4.fsf@clusterfs.com>
References: <200501040611.j046BHoq005158@hera.kernel.org>
	 <m14qhxmkw4.fsf@clusterfs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104857514.17176.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 04 Jan 2005 22:03:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like a broken merge to me. When the 3% trick was proposed I
rewrote it as capabilities and submitted it to Linus, now it looks like
some months later the original one has been regurgitated out of -mm

