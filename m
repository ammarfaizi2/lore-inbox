Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbUJWNVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbUJWNVY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 09:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbUJWNVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 09:21:24 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:43787 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261176AbUJWNVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 09:21:15 -0400
Date: Sat, 23 Oct 2004 14:21:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: jeffm@novell.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: The naming wars continue...
Message-ID: <20041023132114.GA31852@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, jeffm@novell.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   o generic acl support for ->permission

..

>   o xattr consolidation v3 - generic xattr API

Jeff, you'd been doing most reiserfs work lately - any chance to convert
reiserfs to these generic APIs?  Once we have all filesystems converted
over maintaince will be much simpler.  Take a look at ext2, ext3, or jfs
on how to use them - I'll do xfs in the meantime.
