Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVDEJoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVDEJoh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVDEJm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:42:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51678 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261648AbVDEJgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:36:41 -0400
Date: Tue, 5 Apr 2005 10:36:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050405093616.GA28866@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
	Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20050405000524.592fc125.akpm@osdl.org> <20050405074405.GE26208@infradead.org> <16978.22078.532831.667378@cargo.ozlabs.ibm.com> <20050405091255.GA28343@infradead.org> <16978.23538.676953.730507@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16978.23538.676953.730507@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 07:35:46PM +1000, Paul Mackerras wrote:
> Christoph Hellwig writes:
> 
> > It's documented where the other filesystem entry points are documented.
> 
> Which is?
> 
> $ grep -r compat_ioctl Documentation
> Documentation/filesystems/Locking:      long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
> Documentation/filesystems/Locking:compat_ioctl:         no
> 
> Marvellous documentation, that. :)

The other methods don't have much more documentation either ;-)

