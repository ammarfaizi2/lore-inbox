Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263978AbTDWHmP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 03:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbTDWHmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 03:42:15 -0400
Received: from nmail1.systems.pipex.net ([62.241.160.130]:54219 "EHLO
	nmail1.systems.pipex.net") by vger.kernel.org with ESMTP
	id S263978AbTDWHmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 03:42:15 -0400
To: <greg@kroah.com>
Subject: Re: Re: [RFC] Device class rework [0/5]
Message-ID: <1051084444.3ea6469c044ef@netmail.pipex.net>
Date: Wed, 23 Apr 2003 08:54:04 +0100
From: "Shaheed R. Haque" <srhaque@iee.org>
Cc: <linux-kernel@vger.kernel.org>, <with@dsl.pipex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: PIPEX NetMail 2.2.0-pre13
X-PIPEX-username: aozw65%dsl.pipex.com
X-Originating-IP: 195.166.116.245
X-Usage: Use of PIPEX NetMail is subject to the PIPEX Terms and Conditions of use
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg,

I support the intent of this patch, but would it not be a better idea to rename 
the struct something like "device_class"? Rationale:

1. See the title of your patch (!!)

2. The word "class" is too generic and conveys no sense that is is to do with 
devices.

3. I know that C++ is never going to make it into the kernel, but...

Thanks, Shaheed


