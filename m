Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWAPTT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWAPTT0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 14:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWAPTT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 14:19:26 -0500
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:65141 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751166AbWAPTTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 14:19:25 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Subject: Re: [2.6.15] screen remains blank after LID switch use
Date: Mon, 16 Jan 2006 14:19:19 -0500
User-Agent: KMail/1.9.1
Cc: Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org
References: <200601160946.51765.lkml@kcore.org> <E1EyQJ1-0006Do-00@chiark.greenend.org.uk>
In-Reply-To: <E1EyQJ1-0006Do-00@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601161419.20633.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 January 2006 04:05, Matthew Garrett wrote:
> Jan De Luyck <lkml@kcore.org> wrote:
> 
> > I've recently gotten an Dell D610 laptop from my company. After some digging I 
> > managed to get Linux running on it, with kernel 2.6.15 at this moment.
> 
> It's a bug in Dell's BIOS. It seems to be present in all their current
> machines that use Intel graphics, and it also happens in Windows if you
> boot in safe mode. I'm trying to work this through with Dell, but it's
> taking a long time and I'm ridiculously busy with real life right now.
> 

Not only Intel. I've learned to never close lid of my Inspiron 8100
(with nvidia chip) ;)

-- 
Dmitry
