Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264524AbUHBXmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbUHBXmj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 19:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUHBXmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 19:42:39 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:43665 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264500AbUHBXiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 19:38:20 -0400
Date: Tue, 3 Aug 2004 00:36:52 +0100
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, dsaxena@plexity.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH TRIVIAL] Add Intel IXP2400 & IXP2800 to PCI.ids
Message-ID: <20040802233652.GI12724@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Jeff Garzik <jgarzik@pobox.com>, dsaxena@plexity.net,
	linux-kernel@vger.kernel.org
References: <20040716170832.GA4997@plexity.net> <40F81020.5010808@pobox.com> <20040716194654.GA20555@redhat.com> <20040716200113.GB20555@redhat.com> <20040802221047.GA15007@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802221047.GA15007@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 03:10:47PM -0700, Greg KH wrote:

 > > How's that sound Greg? Or would you prefer I dump
 > > this into a bk tree you can regularly pull from?
 > > It's only a bit more scripting to do so..
 > 
 > Sending me emails with the patches is fine for me.  Feel free to
 > automate it if you want to, that would really help out.

Ok, will do so.

 > Do we have a way for patches to flow back into sf.net.

You can send unified diffs to pciids@lists.sf.net and the robot
should automatically recognise them, and add them to the
"to be approved" queue. Then its just a matter of how long it
takes for someone with rights to approve entries.

 > I remember we
 > had some "line too long" warnings that we had to fix up by hand in that
 > file that probably didn't make it upstream.

Ah yes, I'd forgotten about those.  I'm not sure if they got fixed
upstream or not. Holler if you spot anything odd, and I'll try my
best to get changes to such entries approved quickly.

 > I'll go grab the latest version of the patch on your site to add to my
 > bk-pci tree right now...

Cool.

		Dave

