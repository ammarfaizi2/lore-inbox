Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315480AbSFYNhz>; Tue, 25 Jun 2002 09:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315481AbSFYNhy>; Tue, 25 Jun 2002 09:37:54 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:43714 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S315480AbSFYNhw>; Tue, 25 Jun 2002 09:37:52 -0400
Message-ID: <3D1871FA.B974E142@nortelnetworks.com>
Date: Tue, 25 Jun 2002 09:36:58 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: "Salvatore D'Angelo" <dangelo.sasaman@tiscalinet.it>,
       Chris McDonald <chris@cs.uwa.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday problem
References: <Pine.LNX.3.95.1020624153816.15499A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:

> This has been running since I first read your mail about 10:00 this
> morning. The kernel is 2.4.18

<code snipped, find it on google>

Using that code, I can reliably trigger the fault on 2.2.17 on a G4 desktop,
while it doesn't trigger on 2.4.18 on a G4 cPCI blade.

I saw this a long time back (a year or two) on 2.2 but never really tracked it
down properly as it wasn't a showstopper and I had other things to do at the
time.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
