Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbTEHJ7U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 05:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbTEHJ7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 05:59:20 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:34575 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261275AbTEHJ7T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 05:59:19 -0400
Date: Thu, 8 May 2003 12:08:32 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Christoph Hellwig <hch@infradead.org>,
       chas williams <chas@locutus.cmf.nrl.navy.mil>, davem@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [ATM] [PATCH] unbalanced exit path in Forerunner HE he_init_one()
Message-ID: <20030508120832.A26472@electric-eye.fr.zoreil.com>
References: <200305071813.h47IDpc9010906@hera.kernel.org> <20030508010146.A20715@electric-eye.fr.zoreil.com> <20030508060640.A24325@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030508060640.A24325@infradead.org>; from hch@infradead.org on Thu, May 08, 2003 at 06:06:40AM +0100
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> :
[...]
> Btw, this driver badly wants a cleanup of the ifdef mess.  Look

It may happen some day in the future.

[...]
> ifdefs all over the place.  Who reviewed this driver before
> inclusion?

Happy relaxed people :o)

--
Ueimor
