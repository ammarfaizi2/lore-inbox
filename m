Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265853AbTLIOJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 09:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265856AbTLIOJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 09:09:45 -0500
Received: from [206.74.63.254] ([206.74.63.254]:26944 "EHLO
	mail.int.sealevel.com") by vger.kernel.org with ESMTP
	id S265853AbTLIOJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 09:09:43 -0500
Subject: Re: Linux GPL and binary module exception clause?
From: Dale Whitchurch <dalew@sealevel.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200312091322.33506.andrew@walrond.org>
References: <000701c3be1c$8a3cfbc0$0301a8c0@comcast.net>
	 <200312091322.33506.andrew@walrond.org>
Content-Type: text/plain
Message-Id: <1070979148.16262.63.camel@oktoberfest>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 09:12:29 -0500
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Dec 2003 14:12:53.0109 (UTC) FILETIME=[88FE8250:01C3BE5E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A question for this thread:

Is the GPL in effect for the kernel so that anybody can enhance the
current drivers and add support for any other device?  If two companies
develop competing products and those products (albeit a few slight
differences) perform the same operations using almost the same hardware,
do we want one company to use the others driver? 

In another sense, does the kernel evolve to reflect this?  If the
overall driver acts the same minus a few hardware differences, does the
kernel source change by abstracting the similarities and allow both
companies to write the device specific code?  Does it instead say that
both cards must have independent source code?  Or do we only allow the
first driver into the source tree?

There are no evil overtones in this email, nor any disgruntled developer
feelings.  I am just reading at this thread and asking myself, "Is the
overall goal for everyone to get along?"

Dale Whitchurch

