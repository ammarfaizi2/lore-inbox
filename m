Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263267AbSJOQ6W>; Tue, 15 Oct 2002 12:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263794AbSJOQ6V>; Tue, 15 Oct 2002 12:58:21 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:6131 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S263267AbSJOQ5Q>; Tue, 15 Oct 2002 12:57:16 -0400
Date: Tue, 15 Oct 2002 13:03:11 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Dan Kegel <dank@kegel.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
Message-ID: <20021015130311.A14596@redhat.com>
References: <3DAB46FD.9010405@watson.ibm.com> <20021015110501.B11395@redhat.com> <3DAC4B0E.EBB3A2AB@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DAC4B0E.EBB3A2AB@kegel.com>; from dank@kegel.com on Tue, Oct 15, 2002 at 10:06:22AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 10:06:22AM -0700, Dan Kegel wrote:
> Doesn't the F_SETSIG/F_SETOWN/SIGIO stuff qualify as a scalable
> alternative?

No.

		-ben
