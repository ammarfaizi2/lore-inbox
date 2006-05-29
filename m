Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWE2SGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWE2SGN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 14:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWE2SGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 14:06:13 -0400
Received: from gw.openss7.com ([142.179.199.224]:39373 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1751150AbWE2SGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 14:06:13 -0400
Date: Mon, 29 May 2006 12:06:11 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question on Space.c
Message-ID: <20060529120611.A30398@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Nick Warne <nick@linicks.net>,
	linux-kernel@vger.kernel.org
References: <200605291849.04769.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200605291849.04769.nick@linicks.net>; from nick@linicks.net on Mon, May 29, 2006 at 06:49:04PM +0100
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick,

On Mon, 29 May 2006, Nick Warne wrote:

> I saw Space.o being build, and seeing as it is Capitalised thought I would see 
> why, and maybe a patch to make it all lower case.
...
...
> I have looked though docs and googled as to why this One File Is Like This to 
> no avail?  Convention?
> 

Yes, convention: SVR4 had a Space.c file for defining drivers.

--brian
