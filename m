Return-Path: <linux-kernel-owner+w=401wt.eu-S932844AbWLNQND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932844AbWLNQND (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 11:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932851AbWLNQND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 11:13:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55571 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932844AbWLNQNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 11:13:00 -0500
Date: Thu, 14 Dec 2006 11:11:33 -0500
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061214161133.GD17115@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, "Martin J. Bligh" <mbligh@mbligh.org>,
	Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org> <4580E37F.8000305@mbligh.org> <20061214130704.GB17565@redhat.com> <20061214150514.GI3629@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214150514.GI3629@stusta.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 04:05:14PM +0100, Adrian Bunk wrote:
 > On Thu, Dec 14, 2006 at 08:07:04AM -0500, Dave Jones wrote:
 > > On Wed, Dec 13, 2006 at 09:39:11PM -0800, Martin J. Bligh wrote:
 > > 
 > > Thing is, if kernel.org kernels get patched to disallow binary modules,
 > > whats to stop Ubuntu (or anyone else) reverting that change in the
 > > kernels they distribute ?  The landscape doesn't really change much,
 > > given that the majority of Linux end-users are probably running
 > > distro kernels.
 > 
 > If a kernel developer or a competitor sends a cease&desist letter to 
 > such a distribution, the situation changes from a complicated "derived 
 > work" discussion to a relatively clear "They circumvented a technical 
 > measure to enforce the copyright.".

C&D's don't work that way.  They can enforce "don't ship my code"
but not "ship my code, or else".  The modification would be just like
any other thats allowable by the GPL.

		Dave

-- 
http://www.codemonkey.org.uk
