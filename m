Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbTEIMbl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 08:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbTEIMbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 08:31:41 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:65535 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S262657AbTEIMbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 08:31:37 -0400
Date: Fri, 9 May 2003 08:41:13 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: Christoph Hellwig <hch@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305090843_MC3-1-381B-B2E9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> You can have multiple mountspoints with the same path, only
> the topmost one will be seen by userland.

  What keeps users from opening files before the upper layer
filesystems get mounted?  And how do you handle user-mountable
media like CD-ROMS?


