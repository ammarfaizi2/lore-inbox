Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264353AbUATEPw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 23:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbUATEPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 23:15:52 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:539 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264353AbUATEPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 23:15:50 -0500
Date: Mon, 19 Jan 2004 20:15:58 -0800
From: Paul Jackson <pj@sgi.com>
To: joe.korty@ccur.com
Cc: colpatch@us.ibm.com, akpm@osdl.org, paulus@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap parsing/printing routines, version 4
Message-Id: <20040119201558.5aa60752.pj@sgi.com>
In-Reply-To: <20040120035756.GA15703@tsunami.ccur.com>
References: <20040114150331.02220d4d.pj@sgi.com>
	<20040115002703.GA20971@tsunami.ccur.com>
	<20040114204009.3dc4c225.pj@sgi.com>
	<20040115081533.63c61d7f.akpm@osdl.org>
	<20040115181525.GA31086@tsunami.ccur.com>
	<20040115161732.458159f5.pj@sgi.com>
	<400873EC.2000406@us.ibm.com>
	<20040117063618.GA14829@tsunami.ccur.com>
	<20040117183929.GA24185@tsunami.ccur.com>
	<400C4966.2030803@us.ibm.com>
	<20040120035756.GA15703@tsunami.ccur.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unlike Andrew, I do believe one can have too many comments. 

How about keeping the comments somewhat separate from the code?

Let the code tell its own story, for those who want to read code.  Let
the comments explain the overall goals and strategy, and perhaps a key
detail or two that might be confusing.

But don't intermingle the two line by line.  They are as two different
languages, that speak to different people, and different parts of the
brain of the bi-lingual.

Make it visually easy for each reader to filter out the 'other stuff.'

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
