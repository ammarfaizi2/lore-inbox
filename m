Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131705AbRCTEFR>; Mon, 19 Mar 2001 23:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131709AbRCTEFH>; Mon, 19 Mar 2001 23:05:07 -0500
Received: from chromium11.wia.com ([207.66.214.139]:9742 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S131705AbRCTEFC>; Mon, 19 Mar 2001 23:05:02 -0500
Message-ID: <3AB6D795.F06C1B18@chromium.com>
Date: Mon, 19 Mar 2001 20:07:49 -0800
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: user space web server accelerator support
In-Reply-To: <3AB6D0A5.EC4807E3@chromium.com>
		<15030.54194.780246.320476@pizda.ninka.net>
		<3AB6D574.8C123AE9@chromium.com> <15030.54685.535763.403057@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fantastic!

I was not aware of it, sorry... where can I find some doc?

 - Fabio

"David S. Miller" wrote:

> Fabio Riccardi writes:
>  > How can Apache "grab" the file descriptor?
>  >
>  > My understanding is that file descriptors are data structures private to
>  > a process...
>  >
>  > Am I missing something?
>
> Unix sockets allow one processes to "give" a file descriptor to
> another process via a facility called "file descriptor passing".
>
> Later,
> David S. Miller
> davem@redhat.com

