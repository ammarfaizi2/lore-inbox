Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266256AbUFPMBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266256AbUFPMBZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 08:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266257AbUFPMBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 08:01:25 -0400
Received: from turkey.mail.pas.earthlink.net ([207.217.120.126]:63415 "EHLO
	turkey.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S266256AbUFPMBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 08:01:22 -0400
From: Eric <eric@cisu.net>
Reply-To: eric@cisu.net
To: gmishkin@bu.edu
Subject: Re: ld segfault at end of 2.6.6 compile
Date: Wed, 16 Jun 2004 07:01:15 -0500
User-Agent: KMail/1.6.2
References: <1087352698.8671.23.camel@amsa> <40CFE50D.10308@t-online.de> <1087382494.8675.32.camel@amsa>
In-Reply-To: <1087382494.8675.32.camel@amsa>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406160701.15857.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 June 2004 05:41 am, Geoff Mishkin wrote:
> I couldn't find exactly what I was looking for in the BIOS utility (IBM
> ThinkPad T42), but I turned on Diagnostics mode and the RAM check, so at
> boot it checked the RAM, which all turned out okay.

The bios does very wimpy checking of ram. If it is indeed a RAM problem, you 
should use a tool like memtest86 in linux (you boot to it, its not a linux 
tool per se) or prime95(is that the name?) in windows. 

> Still having the problem, though.
>
> 			--Geoff Mishkin <gmishkin@bu.edu>
>

> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
