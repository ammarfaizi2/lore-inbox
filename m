Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSGLJuF>; Fri, 12 Jul 2002 05:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315611AbSGLJuE>; Fri, 12 Jul 2002 05:50:04 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:22788 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315419AbSGLJuE>; Fri, 12 Jul 2002 05:50:04 -0400
Date: Fri, 12 Jul 2002 10:52:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org, Paul P Komkoff Jr <i@stingr.net>
Subject: Re: Small fixes for -rc1 kernel
Message-ID: <20020712105252.B27113@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, Paul P Komkoff Jr <i@stingr.net>
References: <20020711195816.GA2280@stingr.net> <20020711210349.A11341@infradead.org> <20020712094316.GC2280@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020712094316.GC2280@stingr.net>; from i@stingr.net on Fri, Jul 12, 2002 at 01:43:16PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 01:43:16PM +0400, Paul P Komkoff Jr wrote:
> And who should fix it? I just don't understand the whole meaning of that
> piece of code which uses proc_get_inode (yet)

fix the driver to use proper procfs interfaces.

