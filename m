Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbUCESoe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 13:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbUCESoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 13:44:34 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:56451 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262198AbUCESob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 13:44:31 -0500
Date: Fri, 5 Mar 2004 18:42:03 +0000
From: Dave Jones <davej@redhat.com>
To: Steve Longerbeam <stevel@mvista.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: new special filesystem for consideration in 2.6/2.7
Message-ID: <20040305184203.GB26176@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Steve Longerbeam <stevel@mvista.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <40462AA1.7010807@mvista.com> <4048C245.7060009@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4048C245.7060009@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 10:09:09AM -0800, Steve Longerbeam wrote:
 > >An intro to PRAMFS along with a technical specification
 > >is at the SourceForge project web page at
 > >http://pramfs.sourceforge.net/. A patch for 2.6.3 has
 > >been released at the SF project site. 
 > 
 > 
 > A new patch for 2.6.4 is available, but it and the 2.6.3 patch
 > are each ~2900 lines, so I won't post here. But here's the intro:

Without commenting on the code, the biggest thing holding back
inclusion of this is likely the comment about there likely being
patents held on parts of that code.

		Dave

