Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271141AbTGPVwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271144AbTGPVwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:52:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:19869 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271141AbTGPVwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:52:33 -0400
Date: Wed, 16 Jul 2003 15:00:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-Id: <20030716150010.6ba8416f.akpm@osdl.org>
In-Reply-To: <20030716213607.GA2773@kroah.com>
References: <20030716184609.GA1913@kroah.com>
	<20030716130915.035a13ca.akpm@osdl.org>
	<20030716210253.GD2279@kroah.com>
	<20030716141320.5bd2a8b3.akpm@osdl.org>
	<20030716213607.GA2773@kroah.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> Who else prints out the dev_t value?

There are only a few places where it happens.  It is random junk like
"mounted filesystem foo on device %d"

