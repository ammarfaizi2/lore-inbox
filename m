Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbTIQXD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 19:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262899AbTIQXD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 19:03:57 -0400
Received: from vena.lwn.net ([206.168.112.25]:52610 "HELO lwn.net")
	by vger.kernel.org with SMTP id S262873AbTIQXD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 19:03:56 -0400
Message-ID: <20030917230353.3610.qmail@lwn.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Export new char dev functions 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Wed, 17 Sep 2003 18:45:49 EDT."
             <20030917224549.GD4920@gtf.org> 
Date: Wed, 17 Sep 2003 17:03:53 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Need to modify export-objs line in fs/Makefile too.

I do?  In 2.5??  I thought that was old, obsolete stuff?

I sure don't find any export-objs lines in -test5...

jon
