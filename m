Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbVJETa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbVJETa1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 15:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbVJETa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 15:30:27 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:12473 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1030333AbVJETa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 15:30:26 -0400
Date: Wed, 5 Oct 2005 15:30:24 -0400
To: Marc Perkel <marc@perkel.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Rik van Riel <riel@redhat.com>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005193024.GG8011@csclub.uwaterloo.ca>
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com> <Pine.LNX.4.63.0510051150570.3798@cuia.boston.redhat.com> <4343F815.4000208@perkel.com> <20051005161527.GU7992@ftp.linux.org.uk> <4343FE1C.7090700@perkel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4343FE1C.7090700@perkel.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 09:23:56AM -0700, Marc Perkel wrote:
> That's not the point. The point is that Netware has a far superior 
> permission system and I am suggesting the the Linux community learn from 
> it and take advantage of seeing what better looks like and improving itself.

Linux is compatible with unix applications.  Netware is not.  Supporting
some useless netware feature at the expense of posix/unix compatibility
would be insane.

If you can't do it with unix permissions or unix permissions + ACL, you
don't need to do it at all most likely, and even more likely you
probably don't actually understand what you are trying to accomplish and
will probably end up making something insecure or broken instead.

Having dealt with netware, trying to administrate that mess was way to
painful and confusing.  What a horrible interface.  I can't imagine
anything I would want to borrow from netware.

Len Sorensen
