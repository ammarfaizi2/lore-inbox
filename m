Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265248AbUFAWJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbUFAWJC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 18:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbUFAWJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 18:09:01 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:26044 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S265248AbUFAWJA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 18:09:00 -0400
Subject: Re: [2.6.6] oops in khubd on usb bluetooth disconnect
From: Marcel Holtmann <marcel@holtmann.org>
To: Florian Lohoff <flo@rfc822.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040601215427.GA9591@paradigm.rfc822.org>
References: <20040601215427.GA9591@paradigm.rfc822.org>
Content-Type: text/plain
Message-Id: <1086127731.7542.19.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 02 Jun 2004 00:08:52 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

> after shortly using a usb bluetooth adapter (builtin Sony C1MHP)
> with rfcomm to a Nokia 6310i disconnecting the adapter caused this oops
> 
> Arch: i386
> Machine: Sony C1MHP
> Kernel: 2.6.6
> Patches: None

try using 2.6.6-mh3 or 2.6.7-rc2. This bug should be fixed there.

Regards

Marcel


