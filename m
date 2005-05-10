Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVEJEFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVEJEFy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 00:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVEJEFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 00:05:53 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:13933 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261449AbVEJEFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 00:05:47 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Mouse pad doesn't work
Date: Mon, 9 May 2005 23:05:45 -0500
User-Agent: KMail/1.8
Cc: Alan Lake <alan.lake@lakeinfoworks.com>
References: <42801AEE.5080308@lakeinfoworks.com>
In-Reply-To: <42801AEE.5080308@lakeinfoworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505092305.45788.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 May 2005 21:22, Alan Lake wrote:
> The following comes from 
> www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html
> 
> [1.] One line summary of the problem:
> 
> Tapping on the mouse pad of my laptop does not work.
>

Hi,

Do you have an ALPS touchpad? Try applying Peter Osterlund's patches
from here:

http://web.telia.com/~u89404340/patches/touchpad/2.6.11/

And his Synaptics X driver:

http://web.telia.com/~u89404340/touchpad/index.html

-- 
Dmitry
