Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbTDHXHL (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 19:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbTDHXHK (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 19:07:10 -0400
Received: from siaag1ae.compuserve.com ([149.174.40.7]:21172 "EHLO
	siaag1ae.compuserve.com") by vger.kernel.org with ESMTP
	id S262549AbTDHXHJ (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 19:07:09 -0400
Date: Tue, 8 Apr 2003 19:15:30 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] printk subsystems
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304081918_MC3-1-3399-F36A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> Well, I think we should first kill all crappy messages -- that
> benefits everyone.


 ...and _I_ want a bootverbose option like FreeBSD has.

 The default should be for each driver to print one line when
it initializes so you know it's there...





--
 Chuck
 I am not a number!
