Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbTFIPhO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 11:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTFIPhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 11:37:14 -0400
Received: from vena.lwn.net ([206.168.112.25]:31378 "HELO eklektix.com")
	by vger.kernel.org with SMTP id S264477AbTFIPhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 11:37:13 -0400
Message-ID: <20030609155051.22121.qmail@eklektix.com>
To: "Lars Unin" <lars_unin@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel spinlocks; when to use; when appropriate? 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Mon, 09 Jun 2003 23:43:59 +0800."
             <20030609154401.6252.qmail@linuxmail.org> 
Date: Mon, 09 Jun 2003 09:50:51 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    When is is appropriate to use spinlocks in the kernel,
> how are they implemented (e.g. syntax, function names) and
> can anyone think of a good area of the kernel for me to look 
> at, that uses them?

May I humbly suggest a look at Linux Device Drivers, Second Edition?  It
goes over locking primitives in a fair amount of detail, and includes
examples of their use.  Available freely online at:

	http://www.xml.com/ldd/chapter/book/index.html

or in your favorite bookstore.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
