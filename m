Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264666AbSJRHGS>; Fri, 18 Oct 2002 03:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264989AbSJRHGR>; Fri, 18 Oct 2002 03:06:17 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:16656 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264666AbSJRHGQ>;
	Fri, 18 Oct 2002 03:06:16 -0400
Date: Fri, 18 Oct 2002 00:11:52 -0700
From: Greg KH <greg@kroah.com>
To: Crispin Cowan <crispin@wirex.com>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021018071152.GL3896@kroah.com>
References: <20021017195015.A4747@infradead.org> <20021017185352.GA32537@kroah.com> <20021017195838.A5325@infradead.org> <20021017190723.GB32537@kroah.com> <20021017210402.A7741@infradead.org> <20021017201030.GA384@kroah.com> <20021017211223.A8095@infradead.org> <3DAFB260.5000206@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAFB260.5000206@wirex.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 12:04:00AM -0700, Crispin Cowan wrote:
> Why the fierce desire to remove something so cheap?

Because it's so crappy :)

And will not work properly on all architectures, which is one of the
biggest reasons to get rid of it, IMHO.

thanks,

greg k-h
