Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWAQMrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWAQMrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 07:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWAQMrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 07:47:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56266 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932465AbWAQMrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 07:47:09 -0500
Date: Tue, 17 Jan 2006 12:47:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 01/17] add /sys/fs
Message-ID: <20060117124707.GA8004@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu> <20060114004028.711485000@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114004028.711485000@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 01:39:49AM +0100, Miklos Szeredi wrote:
> This patch adds an empty /sys/fs, which filesystems can use.

How does this address all the comments on the last submission
(as part of the reiser4 core changes)?

