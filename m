Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263981AbRFEN5v>; Tue, 5 Jun 2001 09:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263983AbRFEN5l>; Tue, 5 Jun 2001 09:57:41 -0400
Received: from [32.97.182.101] ([32.97.182.101]:5875 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263981AbRFEN5c>;
	Tue, 5 Jun 2001 09:57:32 -0400
Importance: Normal
Subject: can I call wake_up_interruptible_all from an interrupt service routine?
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF16FD54A2.6A713929-ON85256A62.004C4B7D@pok.ibm.com>
From: "Bulent Abali" <abali@us.ibm.com>
Date: Tue, 5 Jun 2001 09:57:51 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.07a |May 14, 2001) at 06/05/2001
 09:56:56 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt service routine of a driver makes a wake_up_interruptible_all()
call to wake up a kernel thread.   Is that legitimate?   Thanks for any
      advice
you might have. please cc: your response to me if you decide to post to
the mailing list.
Bulent


