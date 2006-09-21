Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751645AbWIUWY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbWIUWY7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbWIUWY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:24:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3494 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751583AbWIUWY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:24:58 -0400
Date: Thu, 21 Sep 2006 18:24:43 -0400
From: Dave Jones <davej@redhat.com>
To: David Lang <dlang@digitalinsight.com>
Cc: Sean <seanlkml@sympatico.ca>, Dax Kelson <dax@gurulabs.com>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
Message-ID: <20060921222443.GO26683@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	David Lang <dlang@digitalinsight.com>, Sean <seanlkml@sympatico.ca>,
	Dax Kelson <dax@gurulabs.com>,
	Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
	Linux kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <BAYC1-PASMTP025A72C81CFE009C3BB5A5AE200@CEZ.ICE> <20060921175717.272c58ee.seanlkml@sympatico.ca> <Pine.LNX.4.63.0609211455570.17238@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609211455570.17238@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 03:00:48PM -0700, David Lang wrote:

 > for the tarball users they would have to grab 
 > multiple patches to get from the last thing that they have to whatever is 
 > current.

ketchup solves that problem. One command brings any tree up to current.

 > also people could be behind a firewall that prevents git from working properly, 
 > for them tarballs and patches are the right way of doing things.

If they can't git through a firewall, they won't be able to wget a tarball through
it either.

	Dave
