Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbTD1Qac (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 12:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbTD1Qac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 12:30:32 -0400
Received: from [65.198.37.67] ([65.198.37.67]:5563 "EHLO gghcwest.com")
	by vger.kernel.org with ESMTP id S261192AbTD1Qab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 12:30:31 -0400
Date: Mon, 28 Apr 2003 09:42:48 -0700
From: Jeffrey Baker <jwbaker@acm.org>
To: linux-kernel@vger.kernel.org
Subject: Re: ia32 kernel on amd64 box?
Message-ID: <20030428164248.GA25416@heat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering the same thing about peripherals.  The
README in aic79xx driver from adaptec states that the driver
is supported on x86 only.  So I was wary to spec model 39320
HBAs in x86-64 machines.  I'm sure Adaptec is using the term
"support" in the most corporate sense possible, but what if
it really does scribble the disk under SuSE 64-bit kernel?

-jwb
