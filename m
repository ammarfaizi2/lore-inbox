Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132894AbRDPJeW>; Mon, 16 Apr 2001 05:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132895AbRDPJeN>; Mon, 16 Apr 2001 05:34:13 -0400
Received: from [202.54.61.36] ([202.54.61.36]:33923 "EHLO
	gg2ns.delhi.tcs.co.in") by vger.kernel.org with ESMTP
	id <S132894AbRDPJeA>; Mon, 16 Apr 2001 05:34:00 -0400
Message-ID: <3ADAFC74.3905C4D3@delhi.tcs.co.in>
Date: Mon, 16 Apr 2001 15:06:44 +0100
From: umam@delhi.tcs.co.in
X-Mailer: Mozilla 4.5 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: VRRP related
X-MIMETrack: Itemize by SMTP Server on MAILGG2/TCSDELHI/TCS(Release 5.0.5 |September 22, 2000) at
 04/16/2001 03:15:34 PM,
	Serialize by Router on MAILGG2/TCSDELHI/TCS(Release 5.0.5 |September 22, 2000) at
 04/16/2001 03:15:36 PM,
	Serialize complete at 04/16/2001 03:15:36 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am trying to put virtual mac address at the place of physical mac
address , for that I have overwrite source hardware address with virtual
address.Now when I try to ping to this machine with some other
machine.It says request time out.While checking arp -a , gives me
virtual mac address in ARP-Table instead of physical mac address.I want
it should give response to ping  also.what I can do????


thanks

