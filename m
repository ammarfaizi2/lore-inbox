Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbTFYS1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 14:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbTFYS1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 14:27:23 -0400
Received: from atlas.williams.edu ([137.165.4.25]:20836 "EHLO
	atlas.williams.edu") by vger.kernel.org with ESMTP id S264925AbTFYS1W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 14:27:22 -0400
Date: Wed, 25 Jun 2003 14:41:29 -0400 (EDT)
From: Jeremy A Redburn <jredburn@wso.williams.edu>
Subject: Problem detecting SATA drive in 2.4.21-ac2
To: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.21.0306251437300.24753-100000@olga.williams.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am using the latest 2.4-ac kernel (2.4.21-ac2) and trying to get support
for my WD Raptor SATA drive. The kernel detects the SATA controller just
fine and loads it as ide2 and ide3 -- but there is no detection of the
attached drive (which would presumably be hde). Anyone have any advice for
me?

Thanks,
Jeremy Redburn

ps. I've read of a similar problem at
http://www.linuxhardware.org/Features/03/04/16/1610236.shtml -

> Oddly enough, the SATA drives disappeared now that the drive
> controller was detected correctly. This may be an intermediate problem
> while they are still patching up to 2.4.21 stable.

