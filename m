Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265086AbSJWQxh>; Wed, 23 Oct 2002 12:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265089AbSJWQxh>; Wed, 23 Oct 2002 12:53:37 -0400
Received: from mailhost.trendcomms.com ([194.203.249.129]:23059 "EHLO
	mailhost.trendcomms.com") by vger.kernel.org with ESMTP
	id <S265086AbSJWQxf>; Wed, 23 Oct 2002 12:53:35 -0400
Subject: Re: [2.4.18] Problems with sis900.c [solution?]
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.9  November 16, 2001
Message-ID: <OFDCE159DC.4F437D5B-ON80256C5B.005CC67F@trendcomms.com>
From: Richard.Petrie@trendcomms.com
Date: Wed, 23 Oct 2002 17:59:44 +0100
X-MIMETrack: Serialize by Router on TREND_UK_SMTP/TRENDCOMMS(Release 5.0.11  |July 24, 2002) at
 10/23/2002 05:59:47 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
you will notice that in kernel 2.4.18-3 there is an sis900_old.o in
addition to the sis900.o.
I have found this old version works fine and does not give the message.

eth0: Transmit timeout, status 00000004 00000000

Can anyone advise of any reasons why I should not use this?

thanks

Richard


__________________________________________________________________________

Trend Communications Ltd.
Knaves Beech Estate, Loudwater, Bucks, HP10 9QZ, United Kingdom.
Tel: +44 1628 524977.
Fax: +44 1628 810094 (not for confidential documents).

Web: http://www.trendcomms.com

No liability is accepted by Trend Communications Ltd for any loss or damage
incurred through use of this email.


