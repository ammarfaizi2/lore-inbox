Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbUKWXPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbUKWXPN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbUKWXMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:12:36 -0500
Received: from [213.146.154.40] ([213.146.154.40]:22737 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261623AbUKWXMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:12:14 -0500
Date: Tue, 23 Nov 2004 23:12:08 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jakob Oestergaard <jakob@unthought.net>, Phil Dier <phil@dier.us>,
       linux-kernel@vger.kernel.org, Scott Holdren <scott@icglink.com>,
       ziggy <ziggy@icglink.com>, Jack Massari <webmaster@icglink.com>
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm, and xfs
Message-ID: <20041123231208.GA2666@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jakob Oestergaard <jakob@unthought.net>, Phil Dier <phil@dier.us>,
	linux-kernel@vger.kernel.org, Scott Holdren <scott@icglink.com>,
	ziggy <ziggy@icglink.com>, Jack Massari <webmaster@icglink.com>
References: <20041122130622.27edf3e6.phil@dier.us> <20041122161725.21adb932.akpm@osdl.org> <20041123093744.25c09245.phil@dier.us> <20041123170222.GS4469@unthought.net> <20041123223935.GA1889@infradead.org> <20041123225650.GT4469@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123225650.GT4469@unthought.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 11:56:50PM +0100, Jakob Oestergaard wrote:
> Very nice!
> 
> Is that patch on its way into mainline kernels, or is it waiting for
> more test data ?
> 
> I could apply it and test it here if that would help (?)

It's waiting for review right now, but should go into mainline fairly
soon.  Additional testing is of course always welcome.
