Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbUCVU4H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 15:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbUCVU4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 15:56:07 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2432 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262665AbUCVU4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 15:56:05 -0500
Date: Mon, 22 Mar 2004 20:58:08 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200403222058.i2MKw8vb000340@81-2-122-30.bradfords.org.uk>
To: "David Schwartz" <davids@webmaster.com>,
       "Tigran Aivazian" <tigran@veritas.com>,
       "Timothy Miller" <miller@techsource.com>,
       "Justin Piszcz" <jpiszcz@hotmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <WorldClient-F200403221114.AA14370017@webmaster.com>
References: <Pine.LNX.4.44.0403191721110.3892-100000@einstein.homenet>
 <405F0B8D.8040408@techsource.com>
 <Pine.GSO.4.58.0403220736480.8694@south.veritas.com>
 <WorldClient-F200403221114.AA14370017@webmaster.com>
Subject: Re: Linux Kernel Microcode Question
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Do you understand now?
> 
> You are using the word "instruction" to mean something different than 
> what I am using it to mean. I am using "instruction" to mean "the 
> smallest cohesive unit of operation". I do NOT mean "instruction" as 
> in "an operation coded by the programmer".
> 
> I am talking about the case where an "operation" performed in buggy 
> hardware is replaced by an "operation" performed in fixed microcode.

Using the word "operation" in this sense actually adds to the
confusion, because the term 'opcode' is, (or was), in common use for
"an operation coded by the programmer", which is not what you mean by
"operation" at all.

John.
