Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932709AbWCPSwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709AbWCPSwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbWCPSwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:52:43 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:34067 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932709AbWCPSwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:52:42 -0500
Date: Thu, 16 Mar 2006 19:52:33 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
Message-ID: <20060316185233.GD21003@mars.ravnborg.org>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net> <20060316160129.GB6407@infradead.org> <20060316082951.58592fdc.rdunlap@xenotime.net> <20060316163001.GA7222@infradead.org> <20060316174112.GA21003@mars.ravnborg.org> <20060316180047.GW27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316180047.GW27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 06:00:47PM +0000, Al Viro wrote:
> On Thu, Mar 16, 2006 at 06:41:12PM +0100, Sam Ravnborg wrote:
> > I assume that when you are not used to see 'bool', 'true' and 'false'
> > then they hurt the eye, but when used to it it looks natural.
> 
> Five words: kernel is written in C.
Yep - and bool, true and false are part of 'C' - C99.
> 
> Not in Pascal.  Not in C++.  Not in Algol.  "When used to (something
> non-idiomatic in C) it becomes natural" is not a valid argument.
The translation of idiomatic in my dictionary makes bool, true, false
far more idiomatic in the C than NULL.
But history has thaugth us to accept NULL with screaming UPPERCASE
where a null would be idiomatic C.

	Sam
