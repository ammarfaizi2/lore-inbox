Return-Path: <linux-kernel-owner+w=401wt.eu-S1762652AbWLKIfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762652AbWLKIfc (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 03:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762654AbWLKIfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 03:35:32 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:58972 "EHLO
	liaag2af.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762652AbWLKIfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 03:35:31 -0500
Date: Mon, 11 Dec 2006 03:27:36 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: vojtech@suse.cz, ak@muc.de, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>
Message-ID: <200612110330_MC3-1-D49B-BC0E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1165409880.15706.9.camel@localhost>

On Wed, 06 Dec 2006 13:58:00 +0100, Kasper Sandberg wrote:

> > Kasper, what problems (other that the annoying message) are you having?
> if it had only been the messages i wouldnt have complained.
> the thing is, when i get these messages, the app provoking them acts
> very strange, and in some cases, my system simply hardlocks.

You can try the patch I sent you to see if it fixes the Wine app.
(David thought I was proposing it for the mainline kernel but I just
wanted to see whether it made a difference.)

As for the lockups, there are possibly other bugs lurking in 2.6.19.

-- 
Chuck
"Even supernovas have their duller moments."

