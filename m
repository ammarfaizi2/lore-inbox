Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbVKAVKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVKAVKp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVKAVKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:10:45 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:49553 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751204AbVKAVKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:10:44 -0500
Subject: Re: [RFC: 2.6 patch] remove fs/jffs2/ioctl.c
From: Josh Boyer <jdub@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: dwmw2@infradead.org, jffs-dev@axis.com, linux-kernel@vger.kernel.org
In-Reply-To: <20051101205119.GY8009@stusta.de>
References: <20051101205119.GY8009@stusta.de>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 15:10:36 -0600
Message-Id: <1130879436.3775.1.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 21:51 +0100, Adrian Bunk wrote:
> Is there any reason for keeping fs/jffs2/ioctl.c?

I can think of some various things that could be done with it, but that
would require time and effort.  Unless David or Thomas have an
objections, I think it can go.

josh

