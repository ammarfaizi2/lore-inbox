Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbTJEWlW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 18:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbTJEWlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 18:41:22 -0400
Received: from citi.umich.edu ([141.211.92.141]:41260 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S261693AbTJEWlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 18:41:21 -0400
Date: Sun, 5 Oct 2003 18:41:20 -0400
From: Niels Provos <provos@citi.umich.edu>
To: linux-kernel@vger.kernel.org
Subject: epoll and real-time signal support in libevent-0.7b
Message-ID: <20031005224120.GG20273@citi.citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, I just released a new version of libevent that supports
epoll and real-time signals in Linux; see

  http://www.monkey.org/~provos/libevent/

The new version contains:

  - bug fixes in epoll and poll code (with help from brad at livejournal)
  - experimental support for real-time signals (due to taral)
  - change from 4-clause to 3-clause BSD-license

Feedback and comments appreciated.

Thanks,
 Niels.
