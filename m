Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132142AbRBDSFO>; Sun, 4 Feb 2001 13:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132164AbRBDSFE>; Sun, 4 Feb 2001 13:05:04 -0500
Received: from 216.41.5.host170 ([216.41.5.170]:33751 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S132142AbRBDSEp>; Sun, 4 Feb 2001 13:04:45 -0500
Message-Id: <200102041804.f14I4br22433@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Tom Eastep <teastep@seattlefirewall.dyndns.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift 
In-Reply-To: Your message of "Sun, 04 Feb 2001 09:18:43 PST."
             <Pine.LNX.4.30.0102040908320.877-100000@wookie.seattlefirewall.dyndns.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Feb 2001 13:04:37 -0500
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I've discovered that heavy use of vesafb can be a major source of clock
>drift on my system, especially if I don't specify "ypan" or "ywrap". On my

This is extremely interesting. What version of ntp are you using?



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
