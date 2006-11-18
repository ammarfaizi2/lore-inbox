Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755356AbWKRXGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356AbWKRXGT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 18:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755349AbWKRXGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 18:06:19 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:31889 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1755356AbWKRXGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 18:06:18 -0500
Subject: Re: [PATCH 4/4] swsusp: Fix labels
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200611182351.01924.rjw@sisk.pl>
References: <200611182335.27453.rjw@sisk.pl>
	 <200611182351.01924.rjw@sisk.pl>
Content-Type: text/plain
Date: Sun, 19 Nov 2006 10:06:14 +1100
Message-Id: <1163891174.6787.2.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2006-11-18 at 23:51 +0100, Rafael J. Wysocki wrote:
> Move all labels in the swsusp code to the second column, so that they won't
> fool diff -p.

This sounds like working around brokenness in diff -p. Should/could a
patch be submitted to the diff maintainer instead?

Regards,

Nigel

