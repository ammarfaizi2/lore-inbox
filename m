Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290869AbSBSJiW>; Tue, 19 Feb 2002 04:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290966AbSBSJiM>; Tue, 19 Feb 2002 04:38:12 -0500
Received: from [209.39.166.171] ([209.39.166.171]:14599 "EHLO mail.roland.net")
	by vger.kernel.org with ESMTP id <S290961AbSBSJiC>;
	Tue, 19 Feb 2002 04:38:02 -0500
Message-ID: <000701c1b929$33a47c60$ab9eef0c@jimws>
From: "Jim Roland" <jroland@roland.net>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel ethernet alias limit
Date: Tue, 19 Feb 2002 03:38:34 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to remember back in either Kernel 2.0 or 2.2 there was a limit of 256
aliases within the ethX aliasing (eg, eth0, then eth0:0 thru eth0:255).

Has the limit on this been expanded with Kernel 2.4, is it stable and/or
advised?  I have a need to bind more than 256 addresses to a single
interface.  Without installing additional network cards.

Thanks,
Jim Roland, RHCE


