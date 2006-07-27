Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751749AbWG0QqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWG0QqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 12:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWG0QqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 12:46:04 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:50333 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751749AbWG0QqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 12:46:02 -0400
Subject: Re: [patch] ipc/msg.c: clean up coding style
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060727162434.GA29489@elte.hu>
References: <20060727135321.GA24644@elte.hu>
	 <20060727144659.GC6825@martell.zuzino.mipt.ru>
	 <20060727162434.GA29489@elte.hu>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 09:45:59 -0700
Message-Id: <1154018760.23162.35.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-27 at 18:24 +0200, Ingo Molnar wrote:

> > > +			"%10d %10d  %4o  %10lu %10lu %5u %5u %5u %5u %5u %5u %10lu %10lu %10lu\n",

There's still a giant long line there.. I noticed you tend to leave
strings un-touched.

Daniel

