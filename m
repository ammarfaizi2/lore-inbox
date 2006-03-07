Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWCGXTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWCGXTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWCGXTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:19:37 -0500
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:3041 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964798AbWCGXTh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:19:37 -0500
Date: Tue, 7 Mar 2006 18:17:19 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] Document Linux's memory barriers
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200603071819_MC3-1-BA15-3119@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain;
	 charset=ISO-8859-1
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <31492.1141753245@warthog.cambridge.redhat.com>

On Tue, 07 Mar 2006 17:40:45 +0000, David Howells wrote:

> The attached patch documents the Linux kernel's memory barriers.

References:

AMD64 Architecture Programmer's Manual Volume 2: System Programming
        Chapter 7.1: Memory-Access Ordering
        Chapter 7.4: Buffering and Combining Memory Writes

IA-32 Intel Architecture Software Developer’s Manual, Volume 3:
System Programming Guide
        Chapter 7.1: Locked Atomic Operations
        Chapter 7.2: Memory Ordering
        Chapter 7.4: Serializing Instructions




-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"

