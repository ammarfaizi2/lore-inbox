Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966206AbWK2IZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966206AbWK2IZi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 03:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966284AbWK2IZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 03:25:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30858 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966206AbWK2IZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 03:25:37 -0500
Date: Wed, 29 Nov 2006 08:25:36 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/sysv/: remove obsolete documents
Message-ID: <20061129082536.GA12734@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20061129082019.GB11084@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129082019.GB11084@stusta.de>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 09:20:19AM +0100, Adrian Bunk wrote:
> This patch removes two different changelog files from fs/sysv/ and moves 
> the INTRO file to Documentation/filesystems/sysv-fs-intro.txt

ACK on removing the changlogs.
NACK on moving the INTO file.  It should be merged into
Documentation/filesystems/sysv-fs.txt, creating a single document instead.

