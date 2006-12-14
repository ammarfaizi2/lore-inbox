Return-Path: <linux-kernel-owner+w=401wt.eu-S932858AbWLNQbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932858AbWLNQbG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 11:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932859AbWLNQbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 11:31:06 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:4290 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932858AbWLNQbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 11:31:04 -0500
Date: Thu, 14 Dec 2006 17:31:01 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061214163101.GA43130@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
	"Martin J. Bligh" <mbligh@mbligh.org>,
	Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org> <4580E37F.8000305@mbligh.org> <20061214130704.GB17565@redhat.com> <20061214150514.GI3629@stusta.de> <20061214161133.GD17115@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214161133.GD17115@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 11:11:33AM -0500, Dave Jones wrote:
> On Thu, Dec 14, 2006 at 04:05:14PM +0100, Adrian Bunk wrote:
>  > If a kernel developer or a competitor sends a cease&desist letter to 
>  > such a distribution, the situation changes from a complicated "derived 
>  > work" discussion to a relatively clear "They circumvented a technical 
>  > measure to enforce the copyright.".
> 
> C&D's don't work that way.  They can enforce "don't ship my code"
> but not "ship my code, or else".  The modification would be just like
> any other thats allowable by the GPL.

Careful here.  The "technical measure" protection is something
unrelated to the copyright license itself.  Cf the streambox vcr
lawsuit for instance (settled though) where not implementing the
handling of one bit that said "don't save to disk" in original code
seemed to be illegal.

  OG.

