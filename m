Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263929AbTDNUOe (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTDNUOe (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:14:34 -0400
Received: from citi.umich.edu ([141.211.92.141]:46611 "HELO citi.umich.edu")
	by vger.kernel.org with SMTP id S263929AbTDNUOd (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 16:14:33 -0400
Date: Mon, 14 Apr 2003 16:26:21 -0400
From: Niels Provos <provos@citi.umich.edu>
To: linux-kernel@vger.kernel.org
Subject: epoll support in libevent-0.7
Message-ID: <20030414202620.GM22642@citi.citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just released a new version of libevent that supports Linux new
epoll mechanism; see

  http://www.monkey.org/~provos/libevent/

The page contains some performance comparisons for different event
notification mechanisms.

The library supports platform independent high performance network
applications.  It chooses the fastest notification mechansims
supported by the operating system.

Niels.
