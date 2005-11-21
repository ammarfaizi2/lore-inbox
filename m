Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVKUBnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVKUBnn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 20:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbVKUBnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 20:43:42 -0500
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:23961 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932166AbVKUBnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 20:43:42 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Zorglub Olsen" <zorglub_olsen@hotmail.com>
Subject: Re: Oops on 2.6.14
Date: Mon, 21 Nov 2005 12:43:36 +1100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <BAY109-F294DF1CED8A03C75F7DBC190530@phx.gbl>
In-Reply-To: <BAY109-F294DF1CED8A03C75F7DBC190530@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511211243.36810.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005 12:41, Zorglub Olsen wrote:
> Hi,
>
> Con Kolivas wrote:
> >Unfortunately we can only provide support for code we wrote and have
> > access to. The nvidia and other proprietary binary only drivers cause
> > bugs that we are unable to debug. Please try to reproduce the problem
> > without any binary only drivers.
>
> Thank you for your answer. I understand about the binary, I just wasn't
> able to see that it was the sole cause of the oops.

That's an understandable misconception. Drivers can cause corruption anywhere, 
even if the stack trace does not look related to the driver.

Regards,
Con
