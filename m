Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbTKNMKH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 07:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTKNMKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 07:10:07 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:21772 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262449AbTKNMKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 07:10:04 -0500
Date: Fri, 14 Nov 2003 12:10:03 +0000
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
Message-ID: <20031114121003.A6397@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20031107102514.A2437@infradead.org> <Pine.SGI.3.96.1031112174709.40512D-100000@fsgi900.americas.sgi.com> <20031113065844.A16234@infradead.org> <20031113164801.GA27268@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031113164801.GA27268@sgi.com>; from jbarnes@sgi.com on Thu, Nov 13, 2003 at 08:48:01AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 08:48:01AM -0800, Jesse Barnes wrote:
> Are you sure you want to handle it this way?  I'm not sure the code is
> very useful in its current state--I think we might be better off
> downloading an old kernel version for reference and writing new code for
> drivers/xtalk.

Well, maybe that would be a better idea.  But if you remove the xbridge
support please do it as a separate diff so it can be archive easily.

