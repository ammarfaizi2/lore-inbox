Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVDWMwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVDWMwq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 08:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVDWMwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 08:52:46 -0400
Received: from smtp-out-02.utu.fi ([130.232.202.172]:25056 "EHLO
	smtp-out-02.utu.fi") by vger.kernel.org with ESMTP id S261570AbVDWMwp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 08:52:45 -0400
Date: Sat, 23 Apr 2005 15:52:22 +0300
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: CDR read problems with 2.6.11?
In-reply-to: <20050414013619.342cea4e@galactus.localdomain>
To: Bradley Reed <bradreed1@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <200504231552.29505.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <20050414013619.342cea4e@galactus.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 April 2005 02:36, Bradley Reed wrote:

> Today I burnt two data backup CDs onto CD-R (I used k3b if it
> matters) and the burn went 100% fine. No errors, I can read the

Does k3b know to use the -pad cdrecord option?

If I burn without -pad, the data on the disc will fail sha1 check.
