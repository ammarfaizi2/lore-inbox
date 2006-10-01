Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWJAVOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWJAVOn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 17:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWJAVOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 17:14:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41144 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932395AbWJAVOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 17:14:41 -0400
Date: Sun, 1 Oct 2006 17:14:35 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [discuss] Please report all left over "DWARF2 unwinder stucks"
Message-ID: <20061001211435.GC26348@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <200610012201.20544.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610012201.20544.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2006 at 10:01:20PM +0200, Andi Kleen wrote:
 > 
 > All the fixes for known "DWARF2 unwinder stuck at ..." are
 > in Linus -git mainline now.
 > 
 > If you still see any with current -git please report them.

I'm doing a 2.6.18 update for Fedora users soon, so I'll try
and scoop up all these and backport them.  If any pop out of
the woodwork after that, I'll let you know.

	Dave
