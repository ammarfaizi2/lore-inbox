Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbUC2AcD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 19:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbUC2AcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 19:32:03 -0500
Received: from ozlabs.org ([203.10.76.45]:34493 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262521AbUC2AcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 19:32:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16487.27405.198869.969004@cargo.ozlabs.ibm.com>
Date: Mon, 29 Mar 2004 10:17:17 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Ivan Godard" <igodard@pacbell.net>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel support for peer-to-peer protection models...
In-Reply-To: <048e01c413b3$3c3cae60$fc82c23f@pc21>
References: <048e01c413b3$3c3cae60$fc82c23f@pc21>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Godard writes:

> 3) flat, unified virtual addresses (64 bit) so that pointers, including
> inter-space pointers, have the same representation in all spaces

How are you going to implement fork() ?

Paul.
