Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131386AbRC0QUN>; Tue, 27 Mar 2001 11:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131392AbRC0QUE>; Tue, 27 Mar 2001 11:20:04 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:7309 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S131386AbRC0QTo>;
	Tue, 27 Mar 2001 11:19:44 -0500
Message-ID: <3AC0BD77.295FEDF0@mandrakesoft.com>
Date: Tue, 27 Mar 2001 11:19:03 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-20mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Santiago Romero <sromero@servicom2000.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD PCnet32 driver does not compile on 2.4.x
In-Reply-To: <20010327132202.A17371@servicom2000.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Santiago Romero wrote:
>  Sorry for the "private" message... I'm testing some machines
>  (real and virtual) under 2.4.3pre8, that have a AMD PCNET32
>  ethernet driver. This cards works PERFECTLY under 2.2.x, but if
>  I compile 2.4.x, I get a error on pcnet32.c about a function
>  not defined: is_valid_etherdevice().

hmmm.  I just tested a vanilla 2.4.3-pre8, with the drivers/net/Makefile
fix, and I don't see this at all.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
