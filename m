Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130616AbRCPQVm>; Fri, 16 Mar 2001 11:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130618AbRCPQVd>; Fri, 16 Mar 2001 11:21:33 -0500
Received: from [64.41.138.173] ([64.41.138.173]:36274 "EHLO
	simon.digitalimpact.com") by vger.kernel.org with ESMTP
	id <S130616AbRCPQVX>; Fri, 16 Mar 2001 11:21:23 -0500
Message-ID: <3AB23D6A.E0B072C8@digitalimpact.com>
Date: Fri, 16 Mar 2001 08:20:58 -0800
From: "Shane Y. Gibson" <sgibson@digitalimpact.com>
Organization: Digital Impact, Inc.
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
CC: andrewm@uow.edu.au, kaos@ocs.com.au
Subject: Re: Oops 0000 and 0002 on dual PIII 750 2.4.2 SMP platform
In-Reply-To: <Pine.LNX.4.21.0103152311030.4543-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
>
> Can you please try to reproduce it with the following patch against 2.4.2?

Marcelo (et al),

I'll give it a whirl with the patch.  Should I also
try setting `nmi_watchdog=0' in lilo.conf, as Andrew
Morton suggests?

Additionally, I'll upgrade my version of ksymoops.
Unfortunately, I won't get a chance to test all of
this until Monday; at which time I'll report back to
the group.

v/r
Shane
 
--
Shane Y. Gibson                    sgibson@digitalimpact.com
Network Architect                  (408) 447-8253  work
IT Data Center Operations          (408) 447-8298  fax
Digital Impact, Inc.               (650) 302-0193  cellular
                                   (888) 786-4863  pager

 "Outlook not so good." That magic 8-ball knows everything!
  I'll ask about Exchange Server next.           -- unknown
