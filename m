Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbUDCV0N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 16:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUDCV0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 16:26:13 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:47180 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S261982AbUDCV0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 16:26:11 -0500
Date: Sat, 03 Apr 2004 15:25:58 -0600
From: Matt Gulick <gulickconsulting@direcway.com>
Subject: Re: media removed indication!
In-reply-to: <1118873EE1755348B4812EA29C55A9721770B9@esnmail.esntechnologies.co.in>
To: "Jinu M." <jinum@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Reply-to: gulickconsulting@direcway.com
Message-id: <1081027558.5180.2.camel@localhost.localdomain>
Organization: Gulick Consulting
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5)
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <1118873EE1755348B4812EA29C55A9721770B9@esnmail.esntechnologies.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-02 at 06:38, Jinu M. wrote:
> Hi all,
> 
> We are working on the removable media support for our disk driver. 
> 
> I have a couple of questions.
> 
> How do you ask the file system to stop sending buffers to our disk driver (request function) when the media is removed?
> 
> If a disk is already mounted when the media is removed is there a way to stop all IO and umount the disk automatically?
> 
> Any pointers on the same will be of great help.

Jinu,

There is a tread on the Linux-SCSI list dealing with an issue of removable media and associated error.  You might want to check there.

The thread is "bug 2400"

Matt

----------------------------------------
Matt Gulick
Sr. Staff Engineer
Adaptec, Inc.
gulickconsulting@direcway.com
matt_gulick@adaptec.com
(715) 426-0884


