Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281561AbRKUBpn>; Tue, 20 Nov 2001 20:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281162AbRKUBpY>; Tue, 20 Nov 2001 20:45:24 -0500
Received: from [208.129.208.52] ([208.129.208.52]:41234 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S281144AbRKUBpT>;
	Tue, 20 Nov 2001 20:45:19 -0500
Date: Tue, 20 Nov 2001 17:54:47 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: David Relson <relson@osagesoftware.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Shared Memory Problem
In-Reply-To: <4.3.2.7.2.20011120202550.00c239c0@mail.osagesoftware.com>
Message-ID: <Pine.LNX.4.40.0111201751540.1581-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001, David Relson wrote:

> Greetings,
>
> A simple question, I believe ...
>
> I built my own 2.4.15-pre7 kernel today and have a problem - I can't start
> httpd.  Whenever I try I get the following messages:

# grep CONFIG_SYSVIPC .config




- Davide


