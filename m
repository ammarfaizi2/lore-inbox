Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290166AbSAKXas>; Fri, 11 Jan 2002 18:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290165AbSAKXad>; Fri, 11 Jan 2002 18:30:33 -0500
Received: from web20207.mail.yahoo.com ([216.136.226.62]:33546 "HELO
	web20207.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S290164AbSAKXaM>; Fri, 11 Jan 2002 18:30:12 -0500
Message-ID: <20020111233009.29852.qmail@web20207.mail.yahoo.com>
Date: Fri, 11 Jan 2002 15:30:09 -0800 (PST)
From: Vassilis Virvilis <vasvir@yahoo.gr>
Subject: 2.4.18pre2: PLIP broken
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that the recent changes (in 2.4.18pre2) in
parport code broke the PLIP code. I will undo the
changes in parport.c and test tomorow so hopefully I
will follow up with much more information in case my
hunch misguides me or an explicit modification which
triggers the problem for my setup.

In the mean time may I ask:
Is this already known? Should I address to a different
list/person?

I am not subscribed to the list but I will read any
answers from the WWW archives.

Thank you for your time
  .Bill

__________________________________________________
Do You Yahoo!?
Send FREE video emails in Yahoo! Mail!
http://promo.yahoo.com/videomail/
