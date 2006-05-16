Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751635AbWEPHlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbWEPHlG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 03:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWEPHlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 03:41:05 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:10908 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751635AbWEPHlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 03:41:05 -0400
Date: Tue, 16 May 2006 03:41:02 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Over-heating CPU on 2.6.16 with Thinkpad G41
In-Reply-To: <Pine.LNX.4.58.0605160253010.4283@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605160339340.5333@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605160253010.4283@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 May 2006, Steven Rostedt wrote:

>
> Hmm, could this be the "acpi_sleep=s3_bios" that Suspend2 asks for?
> I haven't removed that option yet.

OK, removing this option seems to make my machine run cool again.  So I
guess my bios doesn't support s3 very well.

- Steve

