Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267568AbTACQ1S>; Fri, 3 Jan 2003 11:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267571AbTACQ1S>; Fri, 3 Jan 2003 11:27:18 -0500
Received: from air-2.osdl.org ([65.172.181.6]:23728 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267568AbTACQ1R>;
	Fri, 3 Jan 2003 11:27:17 -0500
Date: Fri, 3 Jan 2003 08:32:55 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Disconnect <lkml@sigkill.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [STUPID] Best looking code to transfer to a t-shirt
In-Reply-To: <1041609546.15509.2.camel@sparky>
Message-ID: <Pine.LNX.4.33L2.0301030831190.32697-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| On Fri, 2003-01-03 at 08:25, Maciej Soltysiak wrote:
| > Hi,
| >
| > I am in a t-shirt transfering frenzy and was wondering which part of the
| > kernel code it would be best to have on my t-shirt.
| > I was looking at my favourite: netfilter code, but it is to clean, short
| > and simple functions, no tons of pointers, no mallocs, no hex numbers, too
| > many defines used. I was looking for something terribly complicated and
| > looking awesome to the eye.
| >
| > How about we have a poll of the most frightening pieces of the kernel ?
| > What are your ideas?

(not 'code')
Take the ASCII art from the Sparc and PA-RISC die() functions, like so:



          die_on_sparc:                      die_on_parisc:
                                       _______________________________
                                      < Your System ate a SPARC! Gah! >
          \|/ ____ \|/                 -------------------------------
          "@'/ .. \`@"                        \   ^__^
          /_| \__/ |_\                         \  (xx)\_______
             \__U_/                               (__)\       )\/\
                                                   U  ||----w |
                                                      ||     ||

###
-- 
~Randy

