Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbWAXEcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWAXEcw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 23:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbWAXEcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 23:32:52 -0500
Received: from xenotime.net ([66.160.160.81]:14285 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030324AbWAXEcv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 23:32:51 -0500
Date: Mon, 23 Jan 2006 20:33:02 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: David =?ISO-8859-1?B?SORyZGVtYW4=?= <david@2gen.com>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH 03/04] Add encryption ops to the keyctl syscall
Message-Id: <20060123203302.3bc01aa9.rdunlap@xenotime.net>
In-Reply-To: <1138048952965@2gen.com>
References: <11380489523918@2gen.com>
	<1138048952965@2gen.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006 21:42:32 +0100 David Härdeman wrote:

> 
> Changes the keyctl syscall to accept six arguments (is it valid to do so?)
> and adds encryption as one of the supported ops for in-kernel keys.

Does this say anything about the amount of syscall testing
that this code has had?

---
~Randy
