Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267943AbUHYPQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267943AbUHYPQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 11:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267827AbUHYPQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 11:16:57 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:52233 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267943AbUHYPQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 11:16:32 -0400
Date: Wed, 25 Aug 2004 16:16:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] TIOCCONS security
Message-ID: <20040825161630.B8896@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20040825151106.GA21687@suse.de> <20040825161504.A8896@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040825161504.A8896@infradead.org>; from hch@infradead.org on Wed, Aug 25, 2004 at 04:15:04PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 04:15:04PM +0100, Christoph Hellwig wrote:
> > Still, I believe that administrators and operators would not like any
> > user to be able to hijack messages that were written to the console.
> > 
> > The only user of TIOCCONS that I am aware of is bootlogd/blogd, which
> > runs as root. Please comment if there are other users.
> 
> Oh, common.  Do your basic research - this has been rejected a few times
> and there have been better proposals.  Just use goggle a little bit.

Umm, I'm smoking crack.  Sorry, for some reason I took this for another
TIOCGDEV submission without reading.

