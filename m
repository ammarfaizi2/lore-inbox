Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932631AbVJEOaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbVJEOaE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbVJEOaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:30:04 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:15811 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932631AbVJEOaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:30:03 -0400
Date: Wed, 5 Oct 2005 10:29:39 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rc3-rt2
In-Reply-To: <Pine.LNX.4.58.0510050928440.23350@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0510051023460.23350@localhost.localdomain>
References: <20051004084405.GA24296@elte.hu> <Pine.LNX.4.58.0510050928440.23350@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, Ingo,

Do you know why time goes backwards when I run hackbench as a realtime
process?  I added the output of start and stop and it does seem to go
backwards.

Thomas?

Oh and this is with -rt8.

-- Steve



