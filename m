Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbUAXArK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 19:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266826AbUAXArJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 19:47:09 -0500
Received: from mail.aei.ca ([206.123.6.14]:48064 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S266825AbUAXArG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 19:47:06 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1-mm2
Date: Fri, 23 Jan 2004 19:46:55 -0500
User-Agent: KMail/1.5.93
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
References: <20040123013740.58a6c1f9.akpm@osdl.org> <200401231012.56686.edt@aei.ca> <20040123104300.401bf385.akpm@osdl.org>
In-Reply-To: <20040123104300.401bf385.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401231946.55379.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 23, 2004 01:43 pm, Andrew Morton wrote:
> Ed Tomlinson <edt@aei.ca> wrote:
> > Hi,
> >
> > This fails to boot here.  Config is 2-rc1 updated with oldconfig.  It
> > seems that it cannot find root.
>
> That's odd.

It turned out to be a distcc problem.  I rebuilt locally and it booting ok
now...

Ed
