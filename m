Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbUKIMWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbUKIMWA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 07:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbUKIMWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 07:22:00 -0500
Received: from web8404.mail.in.yahoo.com ([202.43.219.152]:52393 "HELO
	web8404.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S261385AbUKIMV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 07:21:56 -0500
Message-ID: <20041109122153.29627.qmail@web8404.mail.in.yahoo.com>
Date: Tue, 9 Nov 2004 12:21:53 +0000 (GMT)
From: Praveen CK <ckpraveen4@yahoo.co.in>
Subject: Can I get a notification inside the kernel, when a random process exits or dies
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Is there a mechanism through which I can register a
function within the kernel such that, the registered
function gets called, whenever a process exits or
dies.

Basically, I am implementing socket kind of a
communication mechanism. Here, if the process that
created the socket dies, I want to release the socket
and all associated data structures inside the kernel.

Regards,
Praveen C K.

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony
