Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276704AbRJGW0W>; Sun, 7 Oct 2001 18:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276716AbRJGW0M>; Sun, 7 Oct 2001 18:26:12 -0400
Received: from [208.129.208.52] ([208.129.208.52]:13071 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S276704AbRJGWZx>;
	Sun, 7 Oct 2001 18:25:53 -0400
Date: Sun, 7 Oct 2001 15:31:27 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mika Liljeberg <Mika.Liljeberg@welho.com>
cc: george anzinger <george@mvista.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>,
        Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Context switch times
In-Reply-To: <3BC0D1C9.63C7F218@welho.com>
Message-ID: <Pine.LNX.4.40.0110071528040.7209-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001, Mika Liljeberg wrote:

> How the balance is determined is another issue, though. I basically
> proposed summing the time slices consumed by tasks executing on a single
> CPU and using that as the comparison value. Davide Libenzi, on the other
> hand, simply proposed using the number of tasks.

CPU based number of __running__ tasks.




- Davide


