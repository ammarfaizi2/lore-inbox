Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTLLQqn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 11:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTLLQqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 11:46:43 -0500
Received: from virt-216-40-198-21.ev1servers.net ([216.40.198.21]:9222 "EHLO
	virt-216-40-198-21.ev1servers.net") by vger.kernel.org with ESMTP
	id S261305AbTLLQqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 11:46:42 -0500
Date: Fri, 12 Dec 2003 10:34:22 -0600
From: Chuck Campbell <campbell@accelinc.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Message-ID: <20031212163422.GA4051@helium.inexs.com>
Reply-To: campbell@accelinc.com
Mail-Followup-To: Chuck Campbell <campbell@accelinc.com>,
	Jamie Lokier <jamie@shareable.org>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
	linux-kernel@vger.kernel.org
References: <3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com> <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org> <20031209075619.GA1698@kroah.com> <1070960433.869.77.camel@nomade> <20031209090815.GA2681@kroah.com> <buoiskqfivq.fsf@mcspd15.ucom.lsi.nec.co.jp> <yw1xd6ayib3f.fsf@kth.se> <3FD5AB6C.3040008@aitel.hist.no> <20031212112636.GA12727@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212112636.GA12727@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 11:26:36AM +0000, Jamie Lokier wrote:
> 
> If anyone wants to do this _properly_, this is what to do:
> 

I might have missed something, but this is only for modular devices right?
No application to devices compiled in monolithically?

Is there already in place similar functionality for non-modules?

-chuck

-- 
