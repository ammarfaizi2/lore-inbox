Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbVHaBj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbVHaBj4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 21:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbVHaBj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 21:39:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24745 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932325AbVHaBjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 21:39:55 -0400
Date: Tue, 30 Aug 2005 18:39:26 -0700
From: Paul Jackson <pj@sgi.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Trailing comments in broken-out series file break quilt
Message-Id: <20050830183926.38f1f11f.pj@sgi.com>
In-Reply-To: <20050830210638.69d8918d.khali@linux-fr.org>
References: <20050829191516.4e5d9e0b.pj@sgi.com>
	<20050830210638.69d8918d.khali@linux-fr.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean wrote:
> You should simply be using an up-to-date version of quilt, namely
> version 0.42, which supports Andrew-style comments in series files just
> fine.

Right you are - that works too.  Thanks for the good work on quilt
and thanks for pointing this out.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
