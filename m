Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbUENSw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUENSw7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 14:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUENSwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 14:52:04 -0400
Received: from host206.200-117-132.telecom.net.ar ([200.117.132.206]:60101
	"EHLO smtp.bensa.ar") by vger.kernel.org with ESMTP id S262100AbUENSuW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 14:50:22 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: does udev support sw raid0?
Date: Fri, 14 May 2004 15:50:20 -0300
User-Agent: KMail/1.6.2
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>
References: <200405141442.38404.norberto+linux-kernel@bensa.ath.cx> <20040514183450.GA2345@kroah.com> <20040514193913.A27388@infradead.org>
In-Reply-To: <20040514193913.A27388@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405141550.20851.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> md has the chicken-egg problem of having to issue an ioctl on the md device
> to register a gendisk.

So do I need to do something special?

Thanks,
Norberto
