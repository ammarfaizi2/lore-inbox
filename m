Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265082AbUGMNTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265082AbUGMNTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 09:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265097AbUGMNTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 09:19:39 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:2108 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265082AbUGMNTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 09:19:36 -0400
Date: Tue, 13 Jul 2004 06:19:09 -0700
From: Paul Jackson <pj@sgi.com>
To: Naveen Kumar <naveenkrg@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sending messages from kernel
Message-Id: <20040713061909.59f83a0e.pj@sgi.com>
In-Reply-To: <20040712111714.10763.qmail@web41108.mail.yahoo.com>
References: <20040712111714.10763.qmail@web41108.mail.yahoo.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Naveen wrote:
> I was trying to check if you can send a
> notification/message from kernel to a user space
> daemon.

Or consider /sbin/hotplug and the kernel routine call_usermodehelper().

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
