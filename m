Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161038AbWFJW2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbWFJW2J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 18:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161042AbWFJW2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 18:28:09 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:25031 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161038AbWFJW2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 18:28:05 -0400
Message-ID: <448B4773.2020704@garzik.org>
Date: Sat, 10 Jun 2006 18:28:03 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jeff@garzik.org>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       promise_linux@promise.com
Subject: Re: [PATCH] Promise 'stex' driver
References: <20060610160852.GA15316@havoc.gtf.org> <20060610170640.GA25118@infradead.org>
In-Reply-To: <20060610170640.GA25118@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> I've just posted a patch to kill the last non-sg codepath so this should't
> be needed anymore.

BTW, thanks for this.  This will allow me to kill some libata-scsi code.

	Jeff


