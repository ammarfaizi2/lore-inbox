Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132268AbRBNOgI>; Wed, 14 Feb 2001 09:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132352AbRBNOf6>; Wed, 14 Feb 2001 09:35:58 -0500
Received: from cold.fortyoz.org ([64.40.111.214]:61193 "HELO cold.fortyoz.org")
	by vger.kernel.org with SMTP id <S132268AbRBNOfn>;
	Wed, 14 Feb 2001 09:35:43 -0500
Date: Wed, 14 Feb 2001 06:36:20 -0800
From: David Raufeisen <david@fortyoz.org>
To: Jonathan Brugge <jonathan_brugge@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re:  Problem: NIC doesn't work anymore, SIOCIFADDR-errors
Message-ID: <20010214063620.A4486@fortyoz.org>
Reply-To: David Raufeisen <david@fortyoz.org>
In-Reply-To: <F19t0CI76rOJhKPc99i00002310@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <F19t0CI76rOJhKPc99i00002310@hotmail.com>; from "Jonathan Brugge" on Wednesday, 14 February 2001, at 15:17:09 (+0100)
X-Operating-System: Linux 2.2.17 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you using the net-tools from debian? There was a broken one causing these
errors the last few days, is fixed now.

On Wednesday, 14 February 2001, at 15:17:09 (+0100),
Jonathan Brugge wrote:

> Here's the output from dmesg, after deleting some unimportant stuff like 
> sound and graphics-init. I don't see any errors that have something to do 
> with my NIC, the detected type (Winbond 89C940) is the right one.
> 
> Linux version 2.4.0-prerelease (root@odysseus) (gcc version 2.95.3 20010125 
> (prerelease)) #2 Tue Feb 13 20:27:53 CET 2001

-- 
David Raufeisen <david@fortyoz.org>
Cell: (604) 818-3596
