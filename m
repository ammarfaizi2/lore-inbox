Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266581AbUAWPNV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 10:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUAWPNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 10:13:20 -0500
Received: from mail.aei.ca ([206.123.6.14]:42445 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S266581AbUAWPNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 10:13:14 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc1-mm2
Date: Fri, 23 Jan 2004 10:12:56 -0500
User-Agent: KMail/1.5.93
Cc: Andrew Morton <akpm@osdl.org>
References: <20040123013740.58a6c1f9.akpm@osdl.org>
In-Reply-To: <20040123013740.58a6c1f9.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401231012.56686.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This fails to boot here.  Config is 2-rc1 updated with oldconfig.  It seems that it cannot 
find root.  I did enable generic ide.  If required,  I'll enable a serial console and get a log 
tonight.

Ed
