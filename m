Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbTEAXa6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 19:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbTEAXa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 19:30:58 -0400
Received: from siaag1ab.compuserve.com ([149.174.40.4]:64253 "EHLO
	siaag1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262783AbTEAXa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 19:30:57 -0400
Date: Thu, 1 May 2003 19:40:44 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Why DRM exists [was Re: Flame Linus to a crisp!]
To: Scott McDermott <vaxerdec@frontiernet.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305011942_MC3-1-36F3-3225@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott McDermott wrote:

>>  They only leaked information when you edited documents while running
>>  the word processor on a toy OS that didn't zero newly allocated
>>  memory...
>
> um pardon, but does your libc zero newly allocated memory?

 I don't know about libc, but my kernels do.  All of them...

> and why should it, praytell? force a performance hit on everyone, when
> it could just be left to the application to do it?

  It is a security requirement.  Applications cannot be trusted.

------
 Chuck
