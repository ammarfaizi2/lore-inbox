Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267547AbUG3A25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267547AbUG3A25 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 20:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267548AbUG3A25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 20:28:57 -0400
Received: from the-village.bc.nu ([81.2.110.252]:23198 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267547AbUG3A24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 20:28:56 -0400
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Gerrit Huizenga <gh@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       suparna@in.ibm.com, fastboot@osdl.org, mbligh@aracnet.com,
       jbarnes@engr.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m1zn5i2weh.fsf@ebiederm.dsl.xmission.com>
References: <E1BqJQF-00053v-00@w-gerrit2>
	 <m1zn5i2weh.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091143551.1596.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 30 Jul 2004 00:25:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-07-30 at 01:04, Eric W. Biederman wrote:
> The beauty of kexec is all of these fun things become user 
> problems from the point of the view of the sick kernel so
> it does not need to worry about them.
> 
> I will be happy to see a SHA patch for /sbin/kexec.  

crypto/sha1.c provides all the code you need.

