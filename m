Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264400AbTCXSFb>; Mon, 24 Mar 2003 13:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264401AbTCXSFb>; Mon, 24 Mar 2003 13:05:31 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:42501 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264400AbTCXSFa>; Mon, 24 Mar 2003 13:05:30 -0500
Date: Mon, 24 Mar 2003 18:16:36 +0000
From: Christoph Hellwig <hch@infradead.org>
To: davej@codemonkey.org.uk
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: ancient block_dev patch
Message-ID: <20030324181636.A22228@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	davej@codemonkey.org.uk, akpm@zip.com.au,
	linux-kernel@vger.kernel.org
References: <200303241642.h2OGg735008305@deviant.impure.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303241642.h2OGg735008305@deviant.impure.org.uk>; from davej@codemonkey.org.uk on Mon, Mar 24, 2003 at 04:41:54PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 04:41:54PM +0000, davej@codemonkey.org.uk wrote:
> Andrew,
>  What became of this patch ? Is it needed ?

It's not needed but a nice speedup for certain loads.  IIRC one of them
was INN directly using blockdevices.

