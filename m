Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbTEEVSU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 17:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbTEEVSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 17:18:20 -0400
Received: from siaag2aa.compuserve.com ([149.174.40.131]:22481 "EHLO
	siaag2aa.compuserve.com") by vger.kernel.org with ESMTP
	id S261322AbTEEVST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 17:18:19 -0400
Date: Mon, 5 May 2003 17:29:20 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305051730_MC3-1-3780-86E0@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Lets deal, I'll GPL the trace module if you get me a 
> EXPORT_SYMBOL_GPL(sys_call_table);

 You could always use the rootkit techniques from Phrack 58 to find
the table... seems kind of silly to do that in kernel mode, but it
should work.
