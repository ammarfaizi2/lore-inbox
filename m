Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbTETGXc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 02:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTETGXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 02:23:32 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:14866 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263540AbTETGXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 02:23:31 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: <linux-kernel@vger.kernel.org>
Subject: Re: is there a patch for the routing-table dos?
Date: Tue, 20 May 2003 08:36:23 +0200
User-Agent: KMail/1.5.1
References: <20030520.6322851@knigge.local.net>
In-Reply-To: <20030520.6322851@knigge.local.net>
Cc: Michael Knigge <Michael.Knigge@set-software.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305200836.23567.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 May 2003 08:32, Michael Knigge wrote:

Hi Michael,

> a few days ago I noticed that red hat
> (http://rhn.redhat.com/errata/RHSA-2003-172.html) released a new
> kernel with a fix for a denial-of-serice attack against the routing
> table of the kernel.
> I wonder if there is a official patch for 2.4.x (2.4.18 would be nice)
> and/or if a patch will go into 2.4.21....
Those fix went into 2.4.21-rc2.

http://linux.bkbits.net:8080/linux-2.4/cset@1.1141.2.2?nav=index.html|ChangeSet@-3w

ciao, Marc
