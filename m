Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262860AbVD2SPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbVD2SPe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 14:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbVD2SPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 14:15:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:65184 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262860AbVD2SPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 14:15:30 -0400
Date: Fri, 29 Apr 2005 19:15:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James.Smart@Emulex.Com
Cc: alexdeucher@gmail.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Emulex fibre channel HBA support and SAN connection
Message-ID: <20050429181524.GA11660@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James.Smart@Emulex.Com, alexdeucher@gmail.com,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C2062981@xbl3.ad.emulex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9BB4DECD4CFE6D43AA8EA8D768ED51C2062981@xbl3.ad.emulex.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 02:08:01PM -0400, James.Smart@Emulex.Com wrote:
> We are putting together such a document that will be placed
> out on SourceForge.

My idea was to put in in the driver actually, so that the ->probe routine
can print an error message for the user.

