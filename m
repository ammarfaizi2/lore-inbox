Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265444AbUAZO4v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 09:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbUAZO4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 09:56:51 -0500
Received: from virt-216-40-198-21.ev1servers.net ([216.40.198.21]:24850 "EHLO
	virt-216-40-198-21.ev1servers.net") by vger.kernel.org with ESMTP
	id S264930AbUAZO4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 09:56:50 -0500
Date: Mon, 26 Jan 2004 08:56:33 -0600
From: Chuck Campbell <campbell@accelinc.com>
To: Andrew Morton <akpm@osdl.org>
Cc: campbell@accelinc.com, linux-kernel@vger.kernel.org
Subject: Re: 2.2 kernel and ext3 filesystems
Message-ID: <20040126145633.GA26983@helium.inexs.com>
Reply-To: campbell@accelinc.com
Mail-Followup-To: Chuck Campbell <campbell@accelinc.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040124033208.GA4830@helium.inexs.com> <20040123215848.28dac746.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123215848.28dac746.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 09:58:48PM -0800, Andrew Morton wrote:
> Chuck Campbell <campbell@accelinc.com> wrote:
> >
> > Was the ext3 filesystem ever back ported to the 2.2 kernel series?
> 
> It was written for 2.2, and then forward-ported.
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/sct/ext3/v2.2/

Interesting.  I looked at the system running 2.2, and there are no ext3
options in the running config file.  It may have been later than 2.2.22...

All of this made me remember that an ext3 filesystem can be mounted as ext2, 
so I got done what I really needed anyway.

thanks for the reply,
-chuck

-- 
