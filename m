Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264677AbUHCAdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbUHCAdE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUHCAct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:32:49 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:39060 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264791AbUHCAca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:32:30 -0400
Date: Tue, 3 Aug 2004 01:31:12 +0100
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, dsaxena@plexity.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH TRIVIAL] Add Intel IXP2400 & IXP2800 to PCI.ids
Message-ID: <20040803003112.GJ12724@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Jeff Garzik <jgarzik@pobox.com>, dsaxena@plexity.net,
	linux-kernel@vger.kernel.org
References: <20040716170832.GA4997@plexity.net> <40F81020.5010808@pobox.com> <20040716194654.GA20555@redhat.com> <20040716200113.GB20555@redhat.com> <20040802221047.GA15007@kroah.com> <20040802233652.GI12724@redhat.com> <20040802234635.GA16394@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802234635.GA16394@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 04:46:36PM -0700, Greg KH wrote:

 > > Ah yes, I'd forgotten about those.  I'm not sure if they got fixed
 > > upstream or not. Holler if you spot anything odd, and I'll try my
 > > best to get changes to such entries approved quickly.
 > 
 > I had to fix up a few older ones that your patch reverted, and changed a
 > new one that caused errors.  Once my patch makes it to Linus (after
 > 2.6.8 comes out) it will be pretty easy for us to see the lines that
 > need to get pushed back to sf.net.

Cool. It should be easier to stay in sync if we do this more regularly
than has been done in the past.  I'll try and push them to you before
they grow into 58k monsters again 8-)

		Dave

