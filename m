Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbTDVQnq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 12:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbTDVQnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 12:43:46 -0400
Received: from www.simpsons.de ([213.139.94.182]:43729 "EHLO susi.ggom.de")
	by vger.kernel.org with ESMTP id S263300AbTDVQnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 12:43:16 -0400
Date: Tue, 22 Apr 2003 18:54:34 +0200
From: Julien Oster <frodoid@frodoid.org>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel ring buffer accessible by users
Message-ID: <20030422165434.GA363@ggom.de>
References: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org> <200304221844.05754.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304221844.05754.fsdeveloper@yahoo.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 06:44:05PM +0200, Michael Buesch wrote:

Hello Michael,

> > it's been quite a while that I noticed that any ordinary user, not
> > just root, can type "dmesg" to see the kernel ring buffer.

> just make
> $ chmod 700 /bin/dmesg

Thanks for the answer, but that doesn't help that much, since any user
could copy dmesg from his system or simply code a dmesg replacement
within a few minutes.

Regards,
Julien
