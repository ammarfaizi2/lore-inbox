Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264662AbSJORBB>; Tue, 15 Oct 2002 13:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264661AbSJORBB>; Tue, 15 Oct 2002 13:01:01 -0400
Received: from relay1.pair.com ([209.68.1.20]:6418 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S264662AbSJORBA>;
	Tue, 15 Oct 2002 13:01:00 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3DAC4DEB.3E6002E8@kegel.com>
Date: Tue, 15 Oct 2002 10:18:35 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
References: <3DAB46FD.9010405@watson.ibm.com> <20021015110501.B11395@redhat.com> <3DAC4B0E.EBB3A2AB@kegel.com> <20021015130311.A14596@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> 
> On Tue, Oct 15, 2002 at 10:06:22AM -0700, Dan Kegel wrote:
> > Doesn't the F_SETSIG/F_SETOWN/SIGIO stuff qualify as a scalable
> > alternative?
> 
> No.

What's the worst part about it?  The use of the signal queue?
- Dan
