Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266563AbUAWPjQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 10:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266570AbUAWPjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 10:39:16 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:30642 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266563AbUAWPjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 10:39:15 -0500
Subject: Re: make in 2.6.x
From: David Woodhouse <dwmw2@infradead.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Karel =?ISO-8859-1?Q?Kulhav=FD?= <clock@twibright.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040123152006.GA2142@mars.ravnborg.org>
References: <20040123145048.B1082@beton.cybernet.src>
	 <20040123152006.GA2142@mars.ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1074872350.22405.128.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Fri, 23 Jan 2004 15:39:11 +0000
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-23 at 16:20 +0100, Sam Ravnborg wrote:
> On Fri, Jan 23, 2004 at 02:50:48PM +0000, Karel Kulhavý wrote:
> > Hello
> > 
> > Is it correct to issue "make bzImage modules modules_install"
> > or do I have to do make bzImage; make modules modules_install?
> 
> It is today supported that you specify all targets in one line.

Last time I tried, there were bugs with 'make -j3 bzImage modules'. Is
that now fixed?

-- 
dwmw2

