Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVLPMeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVLPMeT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVLPMeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:34:19 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:42369 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932223AbVLPMeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:34:18 -0500
Subject: Re: 2.6.15-rc5-rt2 slowness
From: Steven Rostedt <rostedt@goodmis.org>
To: G.Ohrner@post.rwth-aachen.de
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <dnu9ak$k5o$1@sea.gmane.org>
References: <dnu8ku$ie4$1@sea.gmane.org>   <dnu9ak$k5o$1@sea.gmane.org>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 07:34:07 -0500
Message-Id: <1134736447.13138.122.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 12:42 +0100, Gunter Ohrner wrote:
> Gunter Ohrner wrote:
> > the other is a high system load and bad responsiveness of the system as a
> > whole. I didn't even bother to measure timer/sleep jitters as the system
> > was dog slow and the fans started to run a full speed nearly immediately.
> 
> Ok, I recompiled the kernel with some debug options and attached
> a /proc/latency_trace output, hoping it will be helpful to track down the
> problem...
> 
> Please tell me if there's anything else I should do.

Sorry, your latency trace doesn't help.  The 45usec is not really a
latency (well not a bad one).

-- Steve
	

