Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264553AbTLGV3W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 16:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbTLGV2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 16:28:55 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:10931 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S264553AbTLGVYf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 16:24:35 -0500
From: Duncan Sands <baldrick@free.fr>
To: Vince <fuzzy77@free.fr>
Subject: Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Sun, 7 Dec 2003 22:24:32 +0100
User-Agent: KMail/1.5.4
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org
References: <3FC4E8C8.4070902@free.fr> <200312070125.56251.baldrick@free.fr> <3FD39722.8000500@free.fr>
In-Reply-To: <3FD39722.8000500@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312072224.32417.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 December 2003 22:09, Vince wrote:
> Duncan Sands wrote:
> > Does this help?  It isn't finished - it represents the current state of
> > my fix. Warning: have barf bag ready.
> >
>  > [patch cut]
>
> Yes, your patch fixes the problem: no more oops and modem_run now exits
> cleanly. Thank you very much !

Hi Vincent, that's great!  I think the fix is solid, but can you please beat on it
a bit just to be sure...

Thanks,

Duncan.
