Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbTIODnO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 23:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbTIODnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 23:43:14 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:50324 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262432AbTIODnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 23:43:13 -0400
Date: Mon, 15 Sep 2003 05:43:12 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Paul Aviles <paul.aviles@palei.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Boot question
Message-ID: <20030915034311.GB11697@DUK2.13thfloor.at>
Mail-Followup-To: Paul Aviles <paul.aviles@palei.com>,
	linux-kernel@vger.kernel.org
References: <001601c37b27$a1ee0ee0$3724050a@avilespaxp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001601c37b27$a1ee0ee0$3724050a@avilespaxp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 09:21:04PM -0400, Paul Aviles wrote:
> Hello, maybe this is simple for most people here, but I cannot find a
> solution to my problem. Is it possible to boot Linux using a .gz or bz2
> kernel file and lilo? no matter what I type I just cannot get them to work.

AFAIK, lilo understands zImage and bzImage but not
.gz and .bz2 compressed kernel images, although
zImage and bzImage use gzip compression ...

HTH,
Herbert

> Thanks and sorry for bothering..
> -pa
