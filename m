Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbTJUNQG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 09:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbTJUNQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 09:16:06 -0400
Received: from turkey.mail.pas.earthlink.net ([207.217.120.126]:59061 "EHLO
	turkey.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262971AbTJUNQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 09:16:05 -0400
Date: Tue, 21 Oct 2003 09:19:15 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: RH7.3 can't compile 2.6.0-test8
Message-ID: <20031021131915.GA4436@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The Readme for 2.6.0-test6 still said that gcc 2.95 is required

test8 Changes still says gcc-2.95.3.  I saw the same compile error
on RedHat 7.2.  I ended up using gcc-3.3.1.  Later I saw this patch:

http://marc.theaimsgroup.com/?l=linux-kernel&m=106651554401143&w=2

It's supposed to fix test8 compile with gcc-2.96 for RedHat 7.x.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

