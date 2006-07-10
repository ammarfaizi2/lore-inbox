Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422688AbWGJQiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422688AbWGJQiI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 12:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422689AbWGJQiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 12:38:08 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:15031 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422688AbWGJQiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 12:38:06 -0400
Subject: Re: Linux v2.6.18-rc1
From: Steve Fox <drfickle@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1152441242.4128.33.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	 <pan.2006.07.07.15.41.35.528827@us.ibm.com>
	 <1152441242.4128.33.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Jul 2006 11:38:02 -0500
Message-Id: <1152549482.2658.29.camel@flooterbu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-09 at 20:34 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2006-07-07 at 10:41 -0500, Steve Fox wrote:
> > We've got a ppc64 machine that won't boot with this due to an IDE error.
> 
> What machine precisely ?

It's called bl5-6 in ABAT and lists itself as a 970 (8842-P1Z).

Also, booting with ide=nodma, as Alan suggested to Will, did not help.

> > [snip]
> > Freeing unused kernel memory: 256k freed
> >  running (1:2) /init autobench_args: ABAT:1152213829
> > 
> > creating device nodes .hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > 
> 
-- 

Steve Fox
IBM Linux Technology Center
