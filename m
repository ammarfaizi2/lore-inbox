Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTKRFKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 00:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTKRFKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 00:10:24 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:61951 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262052AbTKRFKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 00:10:18 -0500
Subject: Re: [PATCH] Add lib/parser.c kernel-doc
From: Will Dyson <will_dyson@pobox.com>
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: rddunlap@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1069097920.2324.20.camel@patrh9>
References: <1068970562.19499.11.camel@thalience>
	 <1069022225.19499.59.camel@thalience> <20031117072822.GO26866@lug-owl.de>
	 <1069061369.1139.83.camel@thalience>
	 <20031117085529.427bbb0b.rddunlap@osdl.org>
	 <1069097920.2324.20.camel@patrh9>
Content-Type: text/plain
Message-Id: <1069132216.4106.4.camel@thalience>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 18 Nov 2003 00:10:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-17 at 14:38, Pat LaVarre wrote:
> > BTW, where did you find good references for creating kernel-doc?
> 
> I too ask where?

Documentation/kernel-doc-nano-HOWTO.txt was the best I found. It seems
reasonably complete, even though the name seems to imply there is a full
howto out there somewhere.

> > Evolution mangles in-line patches??

> The Ximian Evolution 1.2.2 here by default does style text "Normal" 
> i.e. aggressively line broken only.  But the "Preformat" style works for
> inline text patches such as my (: newly minted and beautiful but not yet
> rejected for an explicit reason :) linux-scsi patches for making more
> writable devices appear writable.

Thanks for the tip!

-- 
Will Dyson
"Back off man, I'm a scientist!" -Dr. Peter Venkman

