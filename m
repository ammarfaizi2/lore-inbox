Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTDYWoG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 18:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbTDYWoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 18:44:06 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:46385 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264546AbTDYWoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 18:44:05 -0400
Date: Fri, 25 Apr 2003 18:56:12 -0400
From: Bill Nottingham <notting@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: jlnance@unity.ncsu.edu, linux-kernel@vger.kernel.org
Subject: Re: ia32 kernel on amd64 box?
Message-ID: <20030425185612.A26644@devserv.devel.redhat.com>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	jlnance@unity.ncsu.edu, linux-kernel@vger.kernel.org
References: <20030425214500.GA20221@ncsu.edu> <20030425174941.A21747@devserv.devel.redhat.com> <20030425215654.GB2132@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030425215654.GB2132@mail.jlokier.co.uk>; from jamie@shareable.org on Fri, Apr 25, 2003 at 10:56:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier (jamie@shareable.org) said: 
> > Red Hat 7.2 may or may not work, I'm not sure we've tried back that far.
> 
> Why - is there anything at all missing from the AMD64's x86
> compatibility, prior to activating 64 bit mode?
> 
> Or is it just that it should work, but you haven't tested it?

Nothing's wrong from the x86 compat standpoint, it's more
device support I'm unsure about (and that I haven't tested
it.)

Bill
