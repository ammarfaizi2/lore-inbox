Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265463AbUGGUum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265463AbUGGUum (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 16:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUGGUul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 16:50:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:37041 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265463AbUGGUuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 16:50:35 -0400
Subject: Re: [PATCH] modular swim3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040707203934.GA19145@lst.de>
References: <20040707203934.GA19145@lst.de>
Content-Type: text/plain
Message-Id: <1089233317.2026.37.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 07 Jul 2004 15:48:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-07 at 15:39, Christoph Hellwig wrote:
> Needs one magic mediabay symbol exported.  I've also moved the Kconfig
> entry to where it belongs.

Hrm... I wouldn't recommend anybody to try to rmmod it though ...

Ben.


