Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbVJ2USV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVJ2USV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 16:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVJ2USV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 16:18:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14008 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751190AbVJ2USU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 16:18:20 -0400
Date: Sat, 29 Oct 2005 16:18:07 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [git patches] 2.6.x libata updates
In-reply-to: <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0510291609140.5288@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051029182228.GA14495@havoc.gtf.org>
 <20051029121454.5d27aecb.akpm@osdl.org> <4363CB60.2000201@pobox.com>
 <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Oct 2005, Linus Torvalds wrote:

> Now, I've gotten several positive comments on how easy "git bisect" is to 
> use, and I've used it myself, but this is the first time that patch users 
> _really_ become very much second-class citizens, and you can't necessarily 
> always do useful things with just the tar-trees and patches. That's sad, 
> and possibly a really big downside.

Since GIT is real free software that even purists may use without fear, 
this downside is certainly not as critical as it was in the BK days.

The fact is: tar and patches simply do not scale anymore.


Nicolas
