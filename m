Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbTINIoY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 04:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbTINIoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 04:44:24 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:17536 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262338AbTINIoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 04:44:23 -0400
Date: Sun, 14 Sep 2003 09:55:00 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309140855.h8E8t0qc000371@81-2-122-30.bradfords.org.uk>
To: bunk@fs.tum.de, jgarzik@pobox.com
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Cc: davej@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Nothing will change, except that if you want to support all CPUs, you 
> > have to select all CPUs instead of 386.
>
> This is incorrect.  You don't want to change the behavior that people 
> are relying on.

Does it matter over a major version change?  Surely as long as the
help text is sufficiently updated it's OK?  Loads of other things have
subtly changed...

John.
