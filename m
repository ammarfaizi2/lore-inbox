Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265605AbTIDWBd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265606AbTIDWBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:01:33 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:7631 "EHLO
	albatross.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S265605AbTIDWBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:01:31 -0400
Message-ID: <008901c37330$18a77d00$2eedfea9@kittycat>
From: "jdow" <jdow@earthlink.net>
To: "Mike Fedyk" <mfedyk@matchmail.com>
Cc: <linux-kernel@vger.kernel.org>
References: <1062637356.846.3471.camel@cube> <200309042114.45234.jimwclark@ntlworld.com> <20030904202707.GF13676@matchmail.com>
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Date: Thu, 4 Sep 2003 15:01:30 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Fedyk" <mfedyk@matchmail.com>

> Have you ever seen the source code available for a windows driver?
Windows
> doesn't let you customize the kernel.  You just get what they give you.
> With the customization possible in Linux you get many advantages, and the
> disadvantage that the binary interface can change depending on the compile
> options.

As a matter of fact, yes. Their (expensive) developer kits have SOME
examples. Of course, much of the information you need for any sort of
driver that is just a weensie bit strange is completely missing. It
makes a specialized USB serial port to MIDI driver very difficult to
build and even worse to deploy neatly without a lot of user interaction.

{^_^}

