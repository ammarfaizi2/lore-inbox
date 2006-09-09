Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWIIQsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWIIQsw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 12:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWIIQsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 12:48:52 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:26597 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932285AbWIIQsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 12:48:51 -0400
Subject: Re: [PATCH -mm] scsi: compile error on module_refcount
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1157819464.8721.24.camel@c-67-188-28-158.hsd1.ca.comcast.net>
References: <20060909162635.746696000@mvista.com>
	 <1157819464.8721.24.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 11:48:41 -0500
Message-Id: <1157820521.3462.11.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch.

On Sat, 2006-09-09 at 09:31 -0700, Daniel Walker wrote
> Cc: linux-kernel@vger.kernel.org

for future reference, SCSI patches should go to
linux-scsi@vger.kernel.org, since most people who read and review them
don't actually subscribe to lkml.

James


