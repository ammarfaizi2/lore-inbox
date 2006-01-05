Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWAEQvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWAEQvs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWAEQvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:51:48 -0500
Received: from server1.bhosted.nl ([217.148.95.133]:19730 "HELO bhosted.nl")
	by vger.kernel.org with SMTP id S1750747AbWAEQvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:51:47 -0500
Message-ID: <53365.145.117.21.143.1136479905.squirrel@145.117.21.143>
In-Reply-To: <3888a5cd0601050849p6ee4cb48s9cc9c9bd6fd20cc8@mail.gmail.com>
References: <20051219190137.GA13923@vanheusden.com>
    <3888a5cd0601050849p6ee4cb48s9cc9c9bd6fd20cc8@mail.gmail.com>
Date: Thu, 5 Jan 2006 17:51:45 +0100 (CET)
Subject: Re: [2.6.13.3] occasional oops mostly in iget_locked
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "Jiri Slaby" <lnx4us@gmail.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No longer happens in 2.6.15.

> On 12/19/05, Folkert van Heusden <folkert@vanheusden.com> wrote:
>> 1. occasional oops with 2.6.13.3
>> 2. see 1
>> 3. fs
>> 4. 2.6.13.3
>> 5. 2.6.11.6 (none tested inbetween)
> and what about later kernel?
> Could you try git bisect (or manual) to determine the exactly frist
> "bad" version as accurate as possible?
>
> thanks,
> --
> Jiri Slaby         www.fi.muni.cz/~xslaby
> ~\-/~      jirislaby@gmail.com      ~\-/~
> B67499670407CE62ACC8 22A032CC55C339D47A7E
>


