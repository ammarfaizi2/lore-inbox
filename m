Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265894AbTL3W1I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265891AbTL3WY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:24:28 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:30932 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265869AbTL3WSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:18:23 -0500
Date: Tue, 30 Dec 2003 17:18:20 -0500
From: Willem Riede <wrlk@riede.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: The survival of ide-scsi in 2.6.x
Message-ID: <20031230221820.GQ1277@linnie.riede.org>
Reply-To: wrlk@riede.org
References: <1072809890.2839.24.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1072809890.2839.24.camel@mulgrave> (from James.Bottomley@steeleye.com on Tue, Dec 30, 2003 at 13:44:49 -0500)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003.12.30 13:44, James Bottomley wrote:
>     If people will have me, I am prepared to take on that responsibility.
>     I am just concerned that I may not have enough of a variety of devices
>     to be able to thoroughly test it (unless the DI-30 is the only one :-)).
>     What do people see as the requirements to be able to maintain ide-scsi?
>     
> Well...there's currently not a long line of people wanting to do this,
> so feel free to send in patches (at least cc'd to linux-scsi so I can
> pick them up easily), and we'll see how it goes.

OK. You did see the patch that came with the original, right? I just sent
it to linux-kernel because the audience there is broader. 

Linus wants Jens to look at it, so I'm waiting for his response.

> In the long term, I think libata will end up assuming much of the role
> that ide-scsi does now, but since it doesn't interface to a lot of
> existing motherboard chipsets, we're going to need ide-scsi around for a
> while at least.

Exactly. Thanks, Willem Riede.
