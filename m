Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbSLERL6>; Thu, 5 Dec 2002 12:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264723AbSLERL6>; Thu, 5 Dec 2002 12:11:58 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:46098 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261907AbSLERL5>; Thu, 5 Dec 2002 12:11:57 -0500
Date: Thu, 5 Dec 2002 17:19:25 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.50
Message-ID: <20021205171925.A31997@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <20021205163152.GA2865@kroah.com> <20021205163234.GB2865@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021205163234.GB2865@kroah.com>; from greg@kroah.com on Thu, Dec 05, 2002 at 08:32:34AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 08:32:34AM -0800, Greg KH wrote:
> ChangeSet 1.797.131.1, 2002/11/30 00:13:57-08:00, steve@kbuxd.necst.nec.co.jp
> 
> [PATCH] fs/namei.c fix
> 
> One of Greg KH's security cleanups reversed the sense of a test.
> Without this patch, 2.5.50 oopses at boot.  Please apply.

Umm, that's already in mainline.

