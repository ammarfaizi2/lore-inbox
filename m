Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161458AbWASWc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161458AbWASWc5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161460AbWASWc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:32:56 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:61830
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1161458AbWASWcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:32:55 -0500
Date: Thu, 19 Jan 2006 14:32:51 -0800
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-m68k@vger.kernel.org,
       geert@linux-m68k.org, torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: License oddity in some m68k files
Message-ID: <20060119223251.GB27106@kroah.com>
References: <20060119180947.GA25001@kroah.com> <Pine.LNX.4.61.0601192014010.30994@scrub.home> <20060119220431.GA4739@kroah.com> <1137708896.8471.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137708896.8471.71.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 10:14:56PM +0000, Alan Cox wrote:
> On Iau, 2006-01-19 at 14:04 -0800, Greg KH wrote:
> > Ah, ok, thanks, that makes sense.  How about a simple pointer to the
> > license info from the .S files to the README file so that people (like
> > me), don't get confused again?  I've attached a patch below if you wish
> > to apply it.
> > 
> They specifically ask as is their right within the GPL that you note if
> you modify the files. Otherwise seems fine.

Hm, any idea on how to note that I modified the file in such a way that
would be acceptable?  How about this?

+|
+|      For details on the license for this file, please see the
+|      file, README, in this same directory.  Note, this paragraph in
+|	this comment has been added from the original version of this
+|	file from the author.

thanks,

greg k-h
