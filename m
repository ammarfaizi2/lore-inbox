Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUIDQON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUIDQON (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 12:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUIDQON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 12:14:13 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:57201 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S264085AbUIDQOL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 12:14:11 -0400
Date: Sat, 4 Sep 2004 18:17:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: thewade <pdman@aproximation.org>
Cc: linux_help <linux-kernel@vger.kernel.org>
Subject: Re: Problem: Compiling kernel: -lqt not found: qt not equal qt-mt?
Message-ID: <20040904161700.GB8216@mars.ravnborg.org>
Mail-Followup-To: thewade <pdman@aproximation.org>,
	linux_help <linux-kernel@vger.kernel.org>
References: <200409041605.i84G5E2G008413@sanctuary.aproximation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409041605.i84G5E2G008413@sanctuary.aproximation.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 10:05:14AM -0600, thewade wrote:
> Abstract:
>    I cannot compile kernel linux-2.6.8-1.521 (fc2) on AMD 64 laptop
>    because compiler cannot find -lqt.

You need qt-devel I think.
But why not using 'make menuconfig', then you do not need qt.
make gconfig is also an option - uses gtk.

	Sam
