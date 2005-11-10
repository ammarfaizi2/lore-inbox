Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbVKJVFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVKJVFI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVKJVFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:05:07 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:65436 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932122AbVKJVFG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:05:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CeTSynzBTYJ3zkI1L9syjXSxuBi27fF2TI0/OBUDlkZKX4xw9+O6MOC4vEro3pD4Tz9H67+Qmw1QCgSzdRqYzWU6kIfHInv/goHl8osqCiV9cKp4X6H8KSR2UDfD5nBQEJ1nhIhv+MpGa5xObUtZcPyMSZLWVCa241TR/xY2A9Y=
Message-ID: <b1bc6a000511101305v7dd396e7g1b9eb7716d6c229a@mail.gmail.com>
Date: Thu, 10 Nov 2005 13:05:05 -0800
From: adam radford <aradford@gmail.com>
To: subbie subbie <subbie_subbie@yahoo.com>
Subject: Re: 3Ware and 2.6.14, problem resurrected
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051110204041.41115.qmail@web30605.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051110204041.41115.qmail@web30605.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/05, subbie subbie <subbie_subbie@yahoo.com> wrote:
> The problem introduced in 2.6.12-mm2 as described
> below appears to have resurfaced in the latest kernel,
> 2.6.14.

The driver you are running from the 3ware website does not have the fix
for this in it.  Please reproduce with the in-kernel v2.26.02.004 driver or
download the 9.3.0.1 driver for 9550SX from the 3ware website, it is backward
compatible to all 9000 series cards.

-Adam
