Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVEPJlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVEPJlw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 05:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVEPJlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 05:41:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15528 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261534AbVEPJli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 05:41:38 -0400
Date: Mon, 16 May 2005 10:41:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [XFS] 2.6.12-rc4: Badness in xfs_page_state_convert at fs/xfs/linux-2.6/xfs_aops.c:889
Message-ID: <20050516094129.GB20828@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20050512193647.GA22976@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512193647.GA22976@hell.org.pl>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 09:36:48PM +0200, Karol Kozimor wrote:
> Hi,
> Just happened to notice, a couple of WARNs and possibly minor fs
> corruption (after the system booted I went straight with SysRq+U, B and
> still got some garbage in the logs).
> Traces below.

should be fixed in current CVS.  I'll send the patch to Linux once he's back.

