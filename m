Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTFGSsg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 14:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTFGSsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 14:48:36 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:2708 "EHLO alpha.stev.org")
	by vger.kernel.org with ESMTP id S263355AbTFGSsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 14:48:30 -0400
Date: Sat, 7 Jun 2003 21:05:42 +0100 (BST)
From: James Stevenson <james@stev.org>
To: Lars Unin <lars_unin@linuxmail.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: What are .s files in arch/i386/boot
In-Reply-To: <20030607185405.15201.qmail@linuxmail.org>
Message-ID: <Pine.LNX.4.44.0306072102580.1776-100000@jlap.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > What are .s files in arch/i386/boot, are they c sources of some sort?
> > > Where can I find the specifications documents they were made from? 
> > 
> > There are not c files.
> > They are assembler files
> > 
> > Try running gcc on a c file with the -S option
> > it will generate the same then you can tweak the
> > assembler produced to make it faster.
> > 
> Where can I find the .c files they were made from,
> and the spec sheets the .c files were made from? 

You would have to find the original author of the person
who tweaks the assembler in the .s file chances are the .c
file is long gone though.

Why do all .c files have to be generated from a spec sheet ?



