Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVCCAki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVCCAki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVCCAgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:36:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22216 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261212AbVCCAdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:33:11 -0500
Date: Wed, 2 Mar 2005 19:32:59 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Lars Marowsky-Bree <lmb@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303003259.GI10124@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Lars Marowsky-Bree <lmb@suse.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302225846.GK17584@marowsky-bree.de> <Pine.LNX.4.58.0503021543430.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503021543430.25732@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 03:44:58PM -0800, Linus Torvalds wrote:

 > > I think a better approach, and one which is already working out well in
 > > practice, is to put "more intrusive" features into -mm first, and only
 > > migrate them into 2.6.x when they have 'stabilized'.
 > 
 > That wouldn't change. But we still have the issue of "they have to be 
 > released sometime". This makes it clear to everybody when to merge, and 
 > when to calm down.

So is the problem that people aren't listening when you say "lets slow down" ?
Why would this change things for people who obviously ignore what you say ? :)

I'll bet you'll still get flooded with "lets see if Linus takes this despite
what he said in his last announcement" patches if we moved to this model.

The only thing that would make a difference afaics, would be you putting
your foot down and just ignoring such submissions ?

		Dave

