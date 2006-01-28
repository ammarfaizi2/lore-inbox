Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751602AbWA1RzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWA1RzE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 12:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbWA1RzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 12:55:01 -0500
Received: from mail.gmx.net ([213.165.64.21]:13532 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751602AbWA1RzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 12:55:00 -0500
X-Authenticated: #4399952
Date: Sat, 28 Jan 2006 18:54:53 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Libin Varghese <libinv@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I/O Scheduling
Message-ID: <20060128185453.12fcd0e6@mango.fruits.de>
In-Reply-To: <43DB405E.4020602@gmail.com>
References: <43DB405E.4020602@gmail.com>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jan 2006 15:28:54 +0530
Libin Varghese <libinv@gmail.com> wrote:

> Hi all,
>         Is there any work done on new I/O scheduling techniques (other
> than as, cfq, noop, deadline)?

Hi,

i'm also interested in these. Especially I/O priorities per process/task
similar to scheduling priorities. It would be just awesome to be able to
give i.e. a hd recording program (or any other data aquisition or
playback program) a high I/O priority.

Image no buffer overruns ever in a hd recorder. Or no more video
dropouts when watching a movie and at the same time copying a file from
the same partition you play the video from.

Is there any work done in this area. I faintly remember to have read
about something like this over a year ago, but have forgotten all the
specifics.

Thanks for all infos and regards,
Florian Schmidt

-- 
Palimm Palimm!
http://tapas.affenbande.org
