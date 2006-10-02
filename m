Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932699AbWJBGyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbWJBGyI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 02:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbWJBGyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 02:54:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62347 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932699AbWJBGyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 02:54:02 -0400
Date: Sun, 1 Oct 2006 23:53:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH 1/5] remove TxStartThresh and RxEarlyThresh
Message-Id: <20061001235312.aa2c6d17.akpm@osdl.org>
In-Reply-To: <1159813431.2576.0.camel@localhost.localdomain>
References: <1159813431.2576.0.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2006 14:23:51 -0400
Jesse Huang <jesse@icplus.com.tw> wrote:

> For pattern issue need to remove TxStartThresh and RxEarlyThresh.

Please describe this issue more completely.

What are the implications of simply removing this feature?  Presumably that
code was there for a reason..
