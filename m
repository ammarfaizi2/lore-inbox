Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbVHUF1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVHUF1I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 01:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVHUF1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 01:27:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34949 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750808AbVHUF1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 01:27:05 -0400
Date: Sun, 21 Aug 2005 01:26:47 -0400
From: Dave Jones <davej@redhat.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: s390 build fix.
Message-ID: <20050821052646.GB19728@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20050821043839.GA28550@redhat.com> <20050821051131.GH29811@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050821051131.GH29811@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2005 at 06:11:31AM +0100, Al Viro wrote:
 > On Sun, Aug 21, 2005 at 12:38:39AM -0400, Dave Jones wrote:
 > > {standard input}: Assembler messages:
 > > {standard input}:397: Error: symbol `.Litfits' is already defined
 > > {standard input}:585: Error: symbol `.Litfits' is already defined
 > > 
 > > Newer gcc's inline this it seems, which blows up.
 > 
 > Eeek...  Much easier (and already sent to Linus):

Sure, that works for me too.

		Dave
