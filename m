Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277567AbRJVSdJ>; Mon, 22 Oct 2001 14:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277568AbRJVSdA>; Mon, 22 Oct 2001 14:33:00 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:51144 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S277567AbRJVScr>; Mon, 22 Oct 2001 14:32:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: James Simmons <jsimmons@transvirtual.com>
Subject: Re: The new X-Kernel !
Date: Mon, 22 Oct 2001 20:35:46 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10110220950310.1738-100000@transvirtual.com>
In-Reply-To: <Pine.LNX.4.10.10110220950310.1738-100000@transvirtual.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <15vjsl-0KiiUiC@fmrl04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 October 2001 18:51, James Simmons wrote:
> > And if two processes need to access it it should be managed by a
> > daemon.
> And if the daemon dies you could end up with a broken mouse if using force
> feedback.

But you have the same problem when the kernel driver dies. So moving the 
daemon into the kernel won't help.

bye...

