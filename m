Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275008AbTHLCp3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 22:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275009AbTHLCp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 22:45:29 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:5885 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S275008AbTHLCp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 22:45:28 -0400
Subject: Re: C99 Initialisers
From: Robert Love <rml@tech9.net>
To: Matthew Wilcox <willy@debian.org>
Cc: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk>
References: <20030812020226.GA4688@zip.com.au>
	 <1060654733.684.267.camel@localhost>
	 <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1060656324.684.276.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Mon, 11 Aug 2003 19:45:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-11 at 19:39, Matthew Wilcox wrote:

> Not unless they're paid by the line ;-)

Agreed.

So, Kernel Janitor folks, here is a good line for the TODO:

"Convert GNU C-style named initializers to C99 named initializers"

And:

"Where the end result is cleaner and more maintainable, convert unnamed
initializers to C99-style named initializers. In almost all cases, named
initializers are safer and less ambiguous, but in some cases the
resulting change is large and unwieldy. Exercise judgment."

	Robert Love

