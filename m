Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWCMJwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWCMJwc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 04:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbWCMJwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 04:52:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20961 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750749AbWCMJwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 04:52:31 -0500
Date: Mon, 13 Mar 2006 10:52:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: akpm@osdl.org, ext2-devel <Ext2-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add "-o bh" option to ext3
Message-ID: <20060313095215.GA3700@elf.ucw.cz>
References: <1142016591.21442.38.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1142016591.21442.38.camel@dyn9047017100.beaverton.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 10-03-06 10:49:50, Badari Pulavarty wrote:
> Its not really need for now, but as we try to make "nobh"
> as default option, it would be nice to have a "-obh" fallback
> option - if things go wrong.

Docs patch is missing...

...and no, it is not even clear to me what bh vs. nobh does...

							Pavel
-- 
13:            fs = new FileStream( Args[ 0 ], FileMode.Open,
