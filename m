Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290277AbSCWDV7>; Fri, 22 Mar 2002 22:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291620AbSCWDVt>; Fri, 22 Mar 2002 22:21:49 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60429 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290277AbSCWDVh>; Fri, 22 Mar 2002 22:21:37 -0500
Date: Fri, 22 Mar 2002 22:19:36 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "joeja@mindspring.com" <joeja@mindspring.com>
cc: "davidel@xmailserver.org" <davidel@xmailserver.org>,
        "davids@webmaster.com" <davids@webmaster.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Re: max number of threads on a system
In-Reply-To: <RELAY3vnamiODNFYHpZ00003e73@relay3.softcomca.com>
Message-ID: <Pine.LNX.3.96.1020322221739.24536B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002, joeja@mindspring.com wrote:

> It would seem that the functionality and behavior of threads on Sun is
> different from that of Linux. 

You probably want to try NGPT, kernel 2.4.19-pre3 and later have the
kernel patches, and the new library is available from IBM. I don't know
about the limits, but the overall functionality should be closer.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

