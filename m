Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261323AbTC3Onn>; Sun, 30 Mar 2003 09:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbTC3Onm>; Sun, 30 Mar 2003 09:43:42 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:15235 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S261323AbTC3Onm>; Sun, 30 Mar 2003 09:43:42 -0500
Date: Sun, 30 Mar 2003 16:50:57 +0200
From: Stelian Pop <stelian@popies.net>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix .text.exit error in sonypi.c
Message-ID: <20030330165057.B10928@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Adrian Bunk <bunk@fs.tum.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030327221331.GB24744@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030327221331.GB24744@fs.tum.de>; from bunk@fs.tum.de on Thu, Mar 27, 2003 at 11:13:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 11:13:31PM +0100, Adrian Bunk wrote:

> The following .text.exit error is present in 2.4.1-pre6 (it seems to be 
> in 2.5.66, too):
[...]

Thanks Adrian, I'll be sending this fix along with other modifications
in my tree to Marcelo and Linus in a minute or two.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
