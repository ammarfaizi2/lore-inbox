Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263931AbTEWIRe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 04:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbTEWIRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 04:17:34 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:31138 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263931AbTEWIRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 04:17:33 -0400
Date: Fri, 23 May 2003 08:30:32 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Hans Boehm <Hans.Boehm@hp.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: [Linux-ia64] Re: web page on O(1) scheduler
Message-ID: <20030523083032.A3197@devserv.devel.redhat.com>
References: <1053507692.1301.1.camel@laptop.fenrus.com> <Pine.LNX.4.44.0305221729070.19071-201000@hoh.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0305221729070.19071-201000@hoh.hpl.hp.com>; from Hans.Boehm@hp.com on Thu, May 22, 2003 at 06:07:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 06:07:46PM -0700, Hans Boehm wrote:
> case.
> 
> On a 1GHz Itanium 2 I get
> 
> Custom lock: 180 msecs
> Custom lock: 1382 msecs
> 
> On a 2GHz Xeon, I get
> 
> Custom lock: 646 msecs
> Custom lock: 1659 msecs

is the pthreads one with nptl ?
