Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267441AbTA3IUH>; Thu, 30 Jan 2003 03:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267442AbTA3IUH>; Thu, 30 Jan 2003 03:20:07 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:64013 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267441AbTA3IUH>; Thu, 30 Jan 2003 03:20:07 -0500
Date: Thu, 30 Jan 2003 08:29:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: John Fremlin <vii@users.sf.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, cw@f00f.org, bcrl@redhat.com
Subject: Re: sys_sendfile64 not in Linux 2.4.21-pre4
Message-ID: <20030130082922.A22879@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	John Fremlin <vii@users.sf.net>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>, cw@f00f.org, bcrl@redhat.com
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva> <86of5z5ur1.fsf@notus.ireton.fremlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <86of5z5ur1.fsf@notus.ireton.fremlin.de>; from vii@users.sf.net on Thu, Jan 30, 2003 at 12:47:14AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2003 at 12:47:14AM +0000, John Fremlin wrote:
> 
> Why isn't sendfile64 included in 2.4.21-pre4? glibc 2.3 already
> expects it, so programs with 64-bit off_t will not be able to use
> sendfile otherwise. And the patch is IIUC very small . . .

I sent patches to Marcelo a few times, but they got silently ignored..

