Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932678AbWCPSAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbWCPSAx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbWCPSAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:00:52 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50154 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932656AbWCPSAw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:00:52 -0500
Date: Thu, 16 Mar 2006 18:00:47 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
Message-ID: <20060316180047.GW27946@ftp.linux.org.uk>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net> <20060316160129.GB6407@infradead.org> <20060316082951.58592fdc.rdunlap@xenotime.net> <20060316163001.GA7222@infradead.org> <20060316174112.GA21003@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316174112.GA21003@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 06:41:12PM +0100, Sam Ravnborg wrote:
> I assume that when you are not used to see 'bool', 'true' and 'false'
> then they hurt the eye, but when used to it it looks natural.

Five words: kernel is written in C.

Not in Pascal.  Not in C++.  Not in Algol.  "When used to (something
non-idiomatic in C) it becomes natural" is not a valid argument.
