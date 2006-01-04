Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965274AbWADWMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965274AbWADWMi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbWADWMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:12:37 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:15767 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965270AbWADWMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:12:36 -0500
Subject: Re: RT : 2.6.15-rt1 and net/ipv6/mcast.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Serge Noiraud <serge.noiraud@bull.net>
In-Reply-To: <Pine.LNX.4.64.0601041234130.22025@dhcp153.mvista.com>
References: <200601041832.39089.Serge.Noiraud@bull.net>
	 <Pine.LNX.4.64.0601041234130.22025@dhcp153.mvista.com>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 17:12:17 -0500
Message-Id: <1136412737.12468.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 12:34 -0800, Daniel Walker wrote:
> I thought I submitted an identical patch, but maybe I forgot to CC LKML .

Nope, you CC'd LKML:
http://marc.theaimsgroup.com/?l=linux-kernel&m=113630942301200&w=2

Ingo has been really busy with getting the mutex stuff into mainline, so
he hasn't had time to update RT or even work on it very much.  Maybe,
I'll start up a patch website to hold patches to Ingo's -rt code until
he has time to work on it again.

-- Steve


