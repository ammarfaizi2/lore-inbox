Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbVD2Lmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVD2Lmd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 07:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbVD2Lmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 07:42:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40600 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262489AbVD2Lm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 07:42:29 -0400
Date: Fri, 29 Apr 2005 12:42:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James.Smart@Emulex.Com
Cc: alexdeucher@gmail.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Emulex fibre channel HBA support and SAN connection
Message-ID: <20050429114225.GA4839@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James.Smart@Emulex.Com, alexdeucher@gmail.com,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C201ABC8@xbl3.ad.emulex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9BB4DECD4CFE6D43AA8EA8D768ED51C201ABC8@xbl3.ad.emulex.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 07:37:01AM -0400, James.Smart@Emulex.Com wrote:
> Based on the "Unknown IOCB command data" message, this appears to be out of date firmware on the adapter. See http://www.emulex.com/ts/indexemu.html.  There are some hints on downloading firmware at the tail end of  http://sourceforge.net/forum/forum.php?thread_id=1130082&forum_id=355154. 

I've seeb quite a bit of these old firmware problems, maybe lpfc should
have a table of minimum required firmware versions for each HBA type?

