Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbUB0SrZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbUB0Sqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:46:30 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:43706 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262934AbUB0Sno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:43:44 -0500
Date: Fri, 27 Feb 2004 18:42:23 +0000
From: Dave Jones <davej@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sysfs is too restrictive
Message-ID: <20040227184223.GB9352@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040227100541.284fb155@dell_ss3.pdx.osdl.net> <20040227181454.GD15016@redhat.com> <20040227103003.4832cbf0@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040227103003.4832cbf0@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 10:30:03AM -0800, Stephen Hemminger wrote:

 > > Shouldn't you be seeing the other side of the bridge in here too ?
 > > Ie, if br0 is a bridge between eth0 and eth1, how does that fit
 > > your plan ?
 > 
 > yes, there would be multiple interfaces in the port directory.
 > More like this:

Ok, that makes more sense.

		Dave

