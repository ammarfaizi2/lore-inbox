Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbUBWFwf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 00:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbUBWFwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 00:52:34 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:8324 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261826AbUBWFwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 00:52:31 -0500
Date: Sun, 22 Feb 2004 21:49:06 -0800
From: Paul Jackson <pj@sgi.com>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-Id: <20040222214906.5cbc544e.pj@sgi.com>
In-Reply-To: <20040222155410.GA3051@hobbes>
References: <20040216133418.GA4399@hobbes>
	<20040222020911.2c8ea5c6.pj@sgi.com>
	<20040222155410.GA3051@hobbes>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW, which shell expects the name of the script in argv[2]?

I don't know.  Someone needs to actually examine the shell code,
and see what it does, for various shells.  My jaw boning neither
proves nor disproves anything.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
