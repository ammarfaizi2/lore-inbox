Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbTHTRRE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 13:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbTHTRRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 13:17:04 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:58752 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262084AbTHTRRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 13:17:02 -0400
Date: Wed, 20 Aug 2003 18:28:47 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308201728.h7KHSlhx000837@81-2-122-30.bradfords.org.uk>
To: greg@kroah.com, john@grabjohn.com
Subject: Re: Console on USB
Cc: linux-kernel@vger.kernel.org, tmolina@cablespeed.com, zwane@linuxpower.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Is there any advice I might be able to use to get this going?  I really 
> > > > want to be able to catch some oops output.
> > >
> > > Buy a machine with a serial port.  That's my recommendation :)
> > 
> > That could be difficult in a few years time.  What are we going to do
> > when we start getting bugs that are only reproducable on laptops with
> > no legacy ports? 
>
> Use the previously mentioned netconsole code.

Yeah, I guess everything will have Ethernet onboard by then :-).

John.
