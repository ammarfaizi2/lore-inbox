Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272140AbTHNIV1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 04:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272229AbTHNIV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 04:21:27 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:33028 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S272140AbTHNIV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 04:21:26 -0400
Subject: Re: 2.6.0-test3-mm2: Badness in class_dev_release at
	drivers/base/class.c
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030813234220.GB7863@kroah.com>
References: <1060803513.1221.2.camel@teapot.felipe-alfaro.com>
	 <20030813234220.GB7863@kroah.com>
Content-Type: text/plain
Message-Id: <1060849280.609.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 14 Aug 2003 10:21:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-14 at 01:42, Greg KH wrote:

> I have a fix for this in my tree, it will get sent to Linus in a few
> days.
> 
> thanks for the report.

And thank you for the fix :-)

