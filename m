Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266999AbVBFHHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266999AbVBFHHL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 02:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269087AbVBFHHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 02:07:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26279 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S268978AbVBFHHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 02:07:04 -0500
Date: Sun, 6 Feb 2005 07:06:59 +0000
From: Christoph Hellwig <hch@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: msdos/vfat defaults are annoying
Message-ID: <20050206070659.GA28596@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	John Richard Moser <nigelenki@comcast.net>,
	linux-kernel@vger.kernel.org
References: <4205AC37.3030301@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4205AC37.3030301@comcast.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 12:33:43AM -0500, John Richard Moser wrote:
> I dunno.  I can never understand the innards of the kernel devs' minds.

filesystem detection isn't handled at the kerne level.

