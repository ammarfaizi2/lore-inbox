Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUCMAUp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 19:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUCMAUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 19:20:45 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:27552 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S262153AbUCMAUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 19:20:44 -0500
Date: Fri, 12 Mar 2004 16:20:27 -0800
From: Tim Hockin <thockin@sun.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: calling flush_scheduled_work()
Message-ID: <20040313002026.GB1333@sun.com>
Reply-To: thockin@sun.com
References: <20040312205814.GY1333@sun.com> <20040312152747.0b3f74d3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312152747.0b3f74d3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 03:27:47PM -0800, Andrew Morton wrote:
> Seems simple enough to fix the workqueue code to handle this situation.

Indeed.  I should have done that myself.  Thanks.

> Wanna test this for me?

Works for me.

-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's
