Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbVCEJ6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVCEJ6R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 04:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbVCEJ6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 04:58:17 -0500
Received: from pils.us-lot.org ([212.67.207.13]:4371 "EHLO pils.us-lot.org")
	by vger.kernel.org with ESMTP id S262844AbVCEJ6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 04:58:06 -0500
To: Greg KH <greg@kroah.com>
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
References: <20050304222146.GA1686@kroah.com>
From: Adam Sampson <azz@us-lot.org>
Organization: Things I did not know at first I learned by doing twice.
Date: Sat, 05 Mar 2005 09:58:00 +0000
In-Reply-To: <20050304222146.GA1686@kroah.com> (Greg KH's message of "Fri, 4
 Mar 2005 14:21:46 -0800")
Message-ID: <y2azmxiifdj.fsf@cartman.at.fivegeeks.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

>  - It must fix a problem that causes a build error (but not for things
>    marked CONFIG_BROKEN), an oops, a hang, or a real security issue.

So a trivial patch that fixed a data corruption issue wouldn't be
accepted?

-- 
Adam Sampson <azz@us-lot.org>                        <http://offog.org/>
