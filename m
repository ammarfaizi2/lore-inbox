Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317886AbSGKUBG>; Thu, 11 Jul 2002 16:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317887AbSGKUBF>; Thu, 11 Jul 2002 16:01:05 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:31503 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317886AbSGKUBE>; Thu, 11 Jul 2002 16:01:04 -0400
Date: Thu, 11 Jul 2002 21:03:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paul P Komkoff Jr <i@stingr.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Small fixes for -rc1 kernel
Message-ID: <20020711210349.A11341@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul P Komkoff Jr <i@stingr.net>, linux-kernel@vger.kernel.org
References: <20020711195816.GA2280@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020711195816.GA2280@stingr.net>; from i@stingr.net on Thu, Jul 11, 2002 at 11:58:16PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2. Long lasting issue with wan/comx and proc_get_inode

comx is broken.  exporting proc_get_inode is still ABSOLUTELY wrong.

