Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264677AbUEEOZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbUEEOZW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 10:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264678AbUEEOZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 10:25:22 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:45702 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264677AbUEEOZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 10:25:19 -0400
Date: Wed, 5 May 2004 07:24:45 -0700
From: Paul Jackson <pj@sgi.com>
To: "Dominic VP" <dominic.vp@globaledgesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: build
Message-Id: <20040505072445.0f9b6576.pj@sgi.com>
In-Reply-To: <016101c432a8$6a64c520$630210ac@dominc>
References: <016101c432a8$6a64c520$630210ac@dominc>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suspect you're in for a rough time of it.

There are a considerable number of gcc extensions to the C language, as
listed at:

  http://gcc.gnu.org/onlinedocs/gcc-3.3.3/gcc/C-Extensions.html#C%20Extensions

and the Linux kernel uses quite a few of them.

What processor architecture is this that gcc doesn't run on it?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
