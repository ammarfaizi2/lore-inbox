Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262588AbTCITpT>; Sun, 9 Mar 2003 14:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262589AbTCITpS>; Sun, 9 Mar 2003 14:45:18 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:47634 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262588AbTCITpS>; Sun, 9 Mar 2003 14:45:18 -0500
Date: Sun, 9 Mar 2003 19:55:55 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dave Jones <davej@codemonkey.org.uk>, Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: struct inode size reduction.
Message-ID: <20030309195555.A22226@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@codemonkey.org.uk>,
	Andries Brouwer <aebr@win.tue.nl>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030309135402.GB32107@suse.de> <20030309171314.GA3783@win.tue.nl> <20030309203359.GA7276@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030309203359.GA7276@suse.de>; from davej@codemonkey.org.uk on Sun, Mar 09, 2003 at 07:33:59PM -0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 07:33:59PM -0100, Dave Jones wrote:
> There still seems to be some users of that, so I'll
> leave that to a follow up patch, (or someone else who
> really knows whats going on there).

No, there are no users yet.  But as people seem to be eager to make
dev_t bigger we'll need when we tackle the "CIDR" thing for character
devices, too.

