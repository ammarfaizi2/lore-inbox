Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263949AbTE0RJF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263957AbTE0RJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:09:04 -0400
Received: from plg2.math.uwaterloo.ca ([129.97.140.200]:54252 "EHLO
	plg2.math.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S263949AbTE0RJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:09:04 -0400
Date: Tue, 27 May 2003 13:19:35 -0400
From: Richard C Bilson <rcbilson@plg2.math.uwaterloo.ca>
Message-Id: <200305271719.NAA27011@plg2.math.uwaterloo.ca>
To: Eric.Piel@Bull.Net, george@mvista.com
Subject: Re: setitimer 1 usec fails
Cc: akpm@digeo.com, davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From Eric.Piel@Bull.Net  Tue May 27 05:05:53 2003
> 
> With the patch atatched the bug seems to go away, for the 030521 release
> of IA64 patch (and probably the previous release also). Could you
> confirm, Richard? I think it's kind of architecture specific because
> this bug shouldn't happen with HZ=1000 (i386) ;-)

Yes -- it fixes the program I posted, as well as my original program.
Thanks very much, Eric!

- Richard
