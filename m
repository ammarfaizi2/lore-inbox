Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUAWSmK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbUAWSmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:42:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:48865 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266646AbUAWSmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:42:05 -0500
Date: Fri, 23 Jan 2004 10:43:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ed Tomlinson <edt@aei.ca>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc1-mm2
Message-Id: <20040123104300.401bf385.akpm@osdl.org>
In-Reply-To: <200401231012.56686.edt@aei.ca>
References: <20040123013740.58a6c1f9.akpm@osdl.org>
	<200401231012.56686.edt@aei.ca>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <edt@aei.ca> wrote:
>
> Hi,
> 
> This fails to boot here.  Config is 2-rc1 updated with oldconfig.  It seems that it cannot 
> find root.

That's odd.

>  I did enable generic ide.  If required,  I'll enable a serial console and get a log 
> tonight.

Would be appreciated, thanks.  Or you could try reverting
suspicious-looking new patches which were added to mm2.

