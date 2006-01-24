Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbWAXTC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbWAXTC6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 14:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161034AbWAXTC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 14:02:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52159 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161033AbWAXTC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 14:02:57 -0500
Date: Tue, 24 Jan 2006 19:02:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] vfs: propagate mnt_flags into do_loopback/vfsmount
Message-ID: <20060124190256.GA14201@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060121083843.GA10044@MAIL.13thfloor.at> <20060121084055.GC10044@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060121084055.GC10044@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one looks good, it's an obvious fix.  But please follow the proper
patch format, see http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
for details.

