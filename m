Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267758AbUHEQJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267758AbUHEQJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 12:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267762AbUHEQJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 12:09:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:26054 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267758AbUHEQJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 12:09:42 -0400
Date: Thu, 5 Aug 2004 09:08:43 -0700
From: Paul Jackson <pj@sgi.com>
To: Olaf Hering <olh@suse.de>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org, spot@redhat.com,
       akpm@osdl.org
Subject: Re: Make MAX_INIT_ARGS 25
Message-Id: <20040805090843.5eaeed43.pj@sgi.com>
In-Reply-To: <20040805143933.GA19219@suse.de>
References: <20040804193243.36009baa@lembas.zaitcev.lan>
	<20040805143933.GA19219@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can the whole thing be dynamic?

We're a little short of dynamic memory allocation mechanisms
this early in the boot, I'm afraid.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
