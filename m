Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVDDT0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVDDT0N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 15:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVDDT0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 15:26:12 -0400
Received: from mail.enyo.de ([212.9.189.167]:27316 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261344AbVDDT0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 15:26:06 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Jonas Diemer <diemer@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: security issue: hard disk lock
References: <200504041942.10976.diemer@gmx.de>
Date: Mon, 04 Apr 2005 21:26:02 +0200
In-Reply-To: <200504041942.10976.diemer@gmx.de> (Jonas Diemer's message of
	"Mon, 4 Apr 2005 19:42:10 +0200")
Message-ID: <8764z2wdh1.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jonas Diemer:

> What do you think of this? 

I think that these days, the underlying assumption (software cannot
destroy hardware, and if it can, we have a problem) is simply no
longer valid.
