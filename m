Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932706AbWJBGys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbWJBGys (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 02:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbWJBGys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 02:54:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12428 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932696AbWJBGyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 02:54:46 -0400
Date: Sun, 1 Oct 2006 23:53:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH 2/5] Fix TX Pause bug (reset_tx, intr_handler)
Message-Id: <20061001235338.566f4a67.akpm@osdl.org>
In-Reply-To: <1159813476.2576.2.camel@localhost.localdomain>
References: <1159813476.2576.2.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2006 14:24:36 -0400
Jesse Huang <jesse@icplus.com.tw> wrote:

> Fix TX Pause bug (reset_tx, intr_handler)

Please describe this bug more completely.    How does this patch solve it?
