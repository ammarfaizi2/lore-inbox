Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbTEURbf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 13:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbTEURbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 13:31:35 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:26131 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262220AbTEURbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 13:31:34 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Christoph Hellwig <hch@infradead.org>, Ross Biro <rossb@google.com>
Subject: Re: Patch FIOFLUSH
Date: Wed, 21 May 2003 19:44:19 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <3ECBB723.7070707@google.com> <20030521183814.A1291@infradead.org>
In-Reply-To: <20030521183814.A1291@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305211944.19442.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 May 2003 19:38, Christoph Hellwig wrote:

Hi Christoph,

> This came up at SGI some time ago and the right solution is _not_ a new
> ioctl but fadvise(..., POSIX_FADV_DONTNEED).   I'll submit a clean backport
could you please send it to me even 2.4.21 is not out? Thank you.

> once 2.4.21 is out (if that will ever happen)
ROTFL! :-)

ciao, Marc
