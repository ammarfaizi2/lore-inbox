Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267190AbTAUTnC>; Tue, 21 Jan 2003 14:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267191AbTAUTnA>; Tue, 21 Jan 2003 14:43:00 -0500
Received: from sj-msg-core-3.cisco.com ([171.70.157.152]:29931 "EHLO
	sj-msg-core-3.cisco.com") by vger.kernel.org with ESMTP
	id <S267190AbTAUTmR>; Tue, 21 Jan 2003 14:42:17 -0500
From: "Hua Zhong" <huaz@sbcglobal.net>
To: "David Schwartz" <davids@webmaster.com>, <dana.lacoste@peregrine.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Is the BitKeeper network protocol documented?
Date: Tue, 21 Jan 2003 11:51:18 -0800
Message-ID: <CDEDIMAGFBEBKHDJPCLDCEEKCFAA.huaz@sbcglobal.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030121183414.AAA4503@shell.webmaster.com@whenever>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	First, I would in fact prefer to have the version control
> information to make changes. The commit comments, for example, may
> explain the rationale for changes.

These comments are not part of the source. The source has its own comments.
They are helpful when you try to track the changes, but GPL doesn't require
releasing the tracking record of a GPL project. It only requires releasing
the
whole source (or diff).

The argument that "BK hosts GPL project so BK has to be GPL'd" is also
ridiculous. If so, let's GPL all disks that store any bit of GPL code,
including
firmware and hardware/chip specs. Then where would we end up? Right,
you cannot find anywhere to host any GPL projects. So it's essentially
killing GPL in the name of purifying and defending it.

