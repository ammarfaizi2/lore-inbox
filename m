Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWANWLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWANWLb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWANWLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:11:31 -0500
Received: from mail.dvmed.net ([216.237.124.58]:59790 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751319AbWANWLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:11:30 -0500
Message-ID: <43C9770F.1000400@pobox.com>
Date: Sat, 14 Jan 2006 17:11:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (actions)
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com> <20060113213311.GI16166@tuxdriver.com> <20060113222512.GN16166@tuxdriver.com>
In-Reply-To: <20060113222512.GN16166@tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  John W. Linville wrote: > Actions > ======= > > I need
	to establish a public git tree for wireless. I would like for > this to
	be on kernel.org, but I haven't got an account established > there yet.
	I've been dragging my feet a little, hoping that the > kernel.org
	account would materialize. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> Actions
> =======
> 
> I need to establish a public git tree for wireless.  I would like for
> this to be on kernel.org, but I haven't got an account established
> there yet.  I've been dragging my feet a little, hoping that the
> kernel.org account would materialize.

> Since we are toying with the issue of multiple stacks (at least in the
> wireless development kernels), some thought needs to be done w.r.t. how
> to make a final decision between the two stacks.  An objective lists
> of functional feature requirements seems like a good place to start.
> IOW, I would like to have a list of features that would trigger the
> removal of one stack shortly after the other stack achieves support
> for the list.  Is this feasible?

Also, an objective and honest list of problems with both stacks should 
be considered...

	Jeff


