Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbVH2PUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbVH2PUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 11:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVH2PUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 11:20:05 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8699 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751229AbVH2PUE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 11:20:04 -0400
Subject: Re: 2.6.13-rt1
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20050829151808.GF19666@elte.hu>
References: <20050829084829.GA23176@elte.hu>
	 <1125327876.22339.0.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050829151808.GF19666@elte.hu>
Content-Type: text/plain
Date: Mon, 29 Aug 2005 08:19:34 -0700
Message-Id: <1125328774.22339.2.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-29 at 17:18 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > On Mon, 2005-08-29 at 10:48 +0200, Ingo Molnar wrote:
> > 
> > > 
> > >  - x86_64 boot fix (Daniel Walker)
> > 
> > Ingo, Did this work for you?
> 
> nope, it's a UP box.


Does it hang early during like ACPI , or after init ?

Daniel

