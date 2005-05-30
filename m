Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVE3TfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVE3TfS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 15:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVE3TfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 15:35:18 -0400
Received: from opersys.com ([64.40.108.71]:10254 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261713AbVE3TeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 15:34:21 -0400
Message-ID: <429B6D14.2070206@opersys.com>
Date: Mon, 30 May 2005 15:44:20 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Esben Nielsen <simlo@phys.au.dk>
CC: James Bruce <bruce@andrew.cmu.edu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: RT patch acceptance
References: <Pine.OSF.4.05.10505302040560.31148-100000@da410.phys.au.dk>
In-Reply-To: <Pine.OSF.4.05.10505302040560.31148-100000@da410.phys.au.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Esben Nielsen wrote:
> very close to nil. (Please, prove me wrong if you have a RT IP-stack
> and maybe a RT USB stack for RTAI.)

Do take me seriously when I say that RTAI is seriously overlooked:

RT-Net (real-time UDP over Ethernet):
http://www.rts.uni-hannover.de/rtnet/

RT-USB (real-time USB):
https://mail.rtai.org/pipermail/rtai/2005-April/011192.html
http://developer.berlios.de/projects/rtusb

Both of these use RTAI on top of Adeos :P

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
