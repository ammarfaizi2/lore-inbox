Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132921AbRDJF3G>; Tue, 10 Apr 2001 01:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132928AbRDJF24>; Tue, 10 Apr 2001 01:28:56 -0400
Received: from [202.54.61.36] ([202.54.61.36]:7361 "EHLO gg2ns.delhi.tcs.co.in")
	by vger.kernel.org with ESMTP id <S132921AbRDJF2n>;
	Tue, 10 Apr 2001 01:28:43 -0400
Message-ID: <3AD2D7B0.AA62925E@delhi.tcs.co.in>
Date: Tue, 10 Apr 2001 10:51:44 +0100
From: umam@delhi.tcs.co.in
X-Mailer: Mozilla 4.5 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Ethernet driver
X-MIMETrack: Itemize by SMTP Server on MAILGG2/TCSDELHI/TCS(Release 5.0.5 |September 22, 2000) at
 04/10/2001 10:59:47 AM,
	Serialize by Router on MAILGG2/TCSDELHI/TCS(Release 5.0.5 |September 22, 2000) at
 04/10/2001 10:59:47 AM,
	Serialize complete at 04/10/2001 10:59:47 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,
I want to put some filter condition on ethernet driver in Promiscuous
mode so as it allow packets to IP stack having Virtual mac address
existing in  say some Dynamic list.Can anybody help how can I do it.

I am using eepro100.

