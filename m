Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbVFRG7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVFRG7m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 02:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVFRG7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 02:59:42 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:59148 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262109AbVFRG7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 02:59:41 -0400
Date: Sat, 18 Jun 2005 08:59:11 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Keith Owens <kaos@ocs.com.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12
Message-ID: <20050618065911.GH8907@alpha.home.local>
References: <21446.1119073126@ocs3.ocs.com.au> <Pine.LNX.4.58.0506172255280.2268@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506172255280.2268@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 11:05:28PM -0700, Linus Torvalds wrote:
 
> Because it's extracted as a regular file (instead of tar knowing that it's 
> a comment header), you will now have a file called "pax_global_header" 
> that has the contents

I guess it will end up in dontdiff quickly :-)

Willy

