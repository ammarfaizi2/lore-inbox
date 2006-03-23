Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWCWVVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWCWVVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWCWVVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:21:51 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:16814 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750922AbWCWVVu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:21:50 -0500
Date: Thu, 23 Mar 2006 21:21:44 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       Maneesh Soni <maneesh@in.ibm.com>, Murali <muralim@in.ibm.com>
Subject: Re: [RFC][PATCH 1/10] 64 bit resources core changes
Message-ID: <20060323212144.GR27946@ftp.linux.org.uk>
References: <20060323195752.GD7175@in.ibm.com> <20060323195944.GE7175@in.ibm.com> <1143145335.3147.52.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0603231250410.26286@g5.osdl.org> <1143147419.3147.54.camel@laptopd505.fenrus.org> <20060323210208.GQ27946@ftp.linux.org.uk> <1143148039.3147.56.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143148039.3147.56.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 10:07:19PM +0100, Arjan van de Ven wrote:

> sure it's all or nothing. not "all but the u64 one"

It's "bugger off and leave them to sparse; it'll do better job" ;-)
