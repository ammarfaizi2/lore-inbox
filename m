Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293053AbSCSWBI>; Tue, 19 Mar 2002 17:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293041AbSCSWA6>; Tue, 19 Mar 2002 17:00:58 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:37369 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S293028AbSCSWAp>; Tue, 19 Mar 2002 17:00:45 -0500
Message-ID: <3C97B721.7A79C4F9@nortelnetworks.com>
Date: Tue, 19 Mar 2002 17:09:37 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <20020316131219.C20436@hq.fsmlabs.com> <Pine.LNX.4.33.0203161223290.31971-100000@penguin.transmeta.com> <20020316143916.A23204@hq.fsmlabs.com> <20020319120618.GA470@elf.ucw.cz> <20020319141231.A22305@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yodaiken@fsmlabs.com wrote:
> 
> On Tue, Mar 19, 2002 at 01:06:19PM +0100, Pavel Machek wrote:
> > Hammer is designed for desktop, AFAICT. [Its slightly modified athlon,
> > you see?]
> 
> Thanks for the insight. Only by reading LKM could
> I have found out that AMD doesn't care about server space.

The sledgehammer is a bit more than a slightly modified athlon...

up to 8 way multiprocessing
64-bit addressing
hypertransport
integrated DDR memory controller


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
