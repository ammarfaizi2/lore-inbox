Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWC3Rk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWC3Rk0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 12:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWC3Rk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 12:40:26 -0500
Received: from test-iport-2.cisco.com ([171.71.176.105]:26037 "EHLO
	test-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932227AbWC3RkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 12:40:25 -0500
To: Al Viro <viro@ftp.linux.org.uk>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, beware <wimille@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Float numbers in module programming
X-Message-Flag: Warning: May contain useful information
References: <3fd7d9680603290634n6fabcdc7r193c30447acc1858@mail.gmail.com>
	<Pine.LNX.4.61.0603290955440.27913@chaos.analogic.com>
	<Pine.LNX.4.61.0603301010400.30783@yvahk01.tjqt.qr>
	<Pine.LNX.4.61.0603300739050.32259@chaos.analogic.com>
	<20060330173136.GZ27946@ftp.linux.org.uk>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 30 Mar 2006 09:40:22 -0800
In-Reply-To: <20060330173136.GZ27946@ftp.linux.org.uk> (Al Viro's message of "Thu, 30 Mar 2006 18:31:36 +0100")
Message-ID: <ada4q1f3k6x.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 Mar 2006 17:40:23.0113 (UTC) FILETIME=[0597DB90:01C65421]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > For instance __all__ real numbers, except for transcendentals, can
 > > be represented as a ratio of two integers.

 > Dear wrongbot, "transcendentals" doesn't mean what you think it means.

Yes, I got a real kick out of his statement, because he has risen
above his usual simple level of wrongness and come up with something
doubly wrong.  First, there are certainly real numbers such as the
square root of 2, which are neither trancendental nor the ratio of
integers.  And anyway, there are infinitely more transcendental
numbers than rational numbers, so only an infinitesimally small
fraction of real numbers can be represented as a ratio of integers.

 - R.
