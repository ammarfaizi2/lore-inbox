Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbUCGSY0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 13:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbUCGSYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 13:24:25 -0500
Received: from [12.177.129.25] ([12.177.129.25]:37315 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262288AbUCGSYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 13:24:25 -0500
Date: Sun, 7 Mar 2004 13:55:33 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: John Bradford <john@grabjohn.com>, Timothy Miller <miller@techsource.com>,
       root@chaos.analogic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel 'simulator' and wave-form analysis tool?
Message-ID: <20040307185533.GA18772@ccure.user-mode-linux.org>
References: <4048B36E.8000605@techsource.com> <Pine.LNX.4.53.0403051253220.32349@chaos> <4048CC7F.4070009@techsource.com> <200403061113.i26BDHrs000517@81-2-122-30.bradfords.org.uk> <404A900B.4020105@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404A900B.4020105@matchmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2004 at 06:59:23PM -0800, Mike Fedyk wrote:
> Can you valgrind a UML process?

Sorta.  I think that valgrind should be able to handle UML.  It just
needs to be told how the kernel memory allocators work before it will
provide any useful debugging information about the kernel.

				Jeff
