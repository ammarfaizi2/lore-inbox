Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbULGTeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbULGTeQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 14:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbULGTeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 14:34:15 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:60104 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261890AbULGTeN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 14:34:13 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] ohci_hcd 0000:00:0f.2: wakeup
Date: Tue, 7 Dec 2004 11:26:02 -0800
User-Agent: KMail/1.7.1
Cc: Flavio Leitner <fbl@conectiva.com.br>, linux-kernel@vger.kernel.org
References: <20041129152040.GA5138@conectiva.com.br>
In-Reply-To: <20041129152040.GA5138@conectiva.com.br>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200412071126.02670.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 November 2004 7:20 am, Flavio Leitner wrote:
> 
> Running bk of today 2004/11/29 I got these messages:
> 
> Nov 29 13:26:19 matrix kernel: ohci_hcd 0000:00:0f.2: wakeup
> Nov 29 13:26:50 matrix last message repeated 61 times
> ...

Well that's wierd, but I did just post an OHCI patch that
resolves an SMP issue I noticed ... it could be the same
issue.

- Dave

