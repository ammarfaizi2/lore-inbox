Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277357AbRJJScF>; Wed, 10 Oct 2001 14:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277359AbRJJSbz>; Wed, 10 Oct 2001 14:31:55 -0400
Received: from [208.129.208.52] ([208.129.208.52]:55045 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S277357AbRJJSbj>;
	Wed, 10 Oct 2001 14:31:39 -0400
Date: Wed, 10 Oct 2001 11:37:27 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Oleg Drokin <green@linuxhacker.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: USB SMP race in 2.4.11
In-Reply-To: <20011010222223.A1223@linuxhacker.ru>
Message-ID: <Pine.LNX.4.40.0110101136500.972-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001, Oleg Drokin wrote:

> Hello!
>
>    I have caught kernel oops that is related to SMP race on usb modules
>    deregistering.
>    2.4.10 was fine with the same setup.
>    USB core is compiled-in, hub driver is uhci (as module).
>    Here is the decoded oops:

It's not SMP related coz i've got the same stuff on UP




- Davide


