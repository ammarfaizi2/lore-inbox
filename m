Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263717AbTKACn6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 21:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbTKACn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 21:43:58 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:22033
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263717AbTKACn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 21:43:57 -0500
Date: Fri, 31 Oct 2003 18:43:56 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Brad Langhorst <brad@langhorst.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops with pci=biosirq in 2.4.22 (not in 2.4.18)
Message-ID: <20031101024356.GB3907@matchmail.com>
Mail-Followup-To: Brad Langhorst <brad@langhorst.com>,
	linux-kernel@vger.kernel.org
References: <1067654215.19557.412.camel@up>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067654215.19557.412.camel@up>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 31, 2003 at 09:36:56PM -0500, Brad Langhorst wrote:
> Unfortunately I can't get a copy of the oops because 
> the screen immediately fills with hex addresses 
> (looks like a looping call trace)
> 
> 2.6.0test9 does not suffer from this problem.
> 
> I don't have time to try more kernels and narrow the window at the
> moment.
> 
> perhaps this is enough information for somebody who knows where to look.

Most likely not.

Did you get any problems with 2.4.21?

What about 2.4.23-pre?

Too much between 2.4.22 and 2.4.18 changed to use this little info to track
anything down...
