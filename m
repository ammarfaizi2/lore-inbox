Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbTFDFKz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 01:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTFDFKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 01:10:55 -0400
Received: from [204.94.215.101] ([204.94.215.101]:31166 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262856AbTFDFKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 01:10:53 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Chuck Harding <charding@llnl.gov>
Cc: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Subject: Re: Subject: Unresolved symbols from 'make modules_install' 
In-reply-to: Your message of "Tue, 03 Jun 2003 10:27:05 MST."
             <Pine.LNX.4.55.0306031017070.9083@ghostwheel.llnl.gov> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Jun 2003 15:24:01 +1000
Message-ID: <1982.1054704241@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jun 2003 10:27:05 -0700 (PDT), 
Chuck Harding <charding@llnl.gov> wrote:
>with no errors, when I run the 'make modules_install' I get a bunch
>of occurrances of unresolved symbol errors from 'depmod -ae -F System.map 2.x.x'
>most of which are for what appear to be core functions that the
>modules would need (output is attached

You did not include any output from make modules_install.

>as is my .config

.config is from a 2.5 kernel, not 2.4.

