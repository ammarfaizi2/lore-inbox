Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbTCQHbN>; Mon, 17 Mar 2003 02:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262044AbTCQHbN>; Mon, 17 Mar 2003 02:31:13 -0500
Received: from holomorphy.com ([66.224.33.161]:2521 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262038AbTCQHbM>;
	Mon, 17 Mar 2003 02:31:12 -0500
Date: Sun, 16 Mar 2003 23:41:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Mark Haverkamp <markh@osdl.org>
Subject: Re: [Lse-tech] [PATCH][ANNOUNCE] 32way/8quad NUMAQ booting with 16 IOAPICs, 223 IRQs
Message-ID: <20030317074149.GO5891@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	LSE <lse-tech@lists.sourceforge.net>,
	Mark Haverkamp <markh@osdl.org>
References: <Pine.LNX.4.50.0303071148150.18716-100000@montezuma.mastecende.com> <20030317055415.GM5891@holomorphy.com> <Pine.LNX.4.50.0303170107560.2229-100000@montezuma.mastecende.com> <20030317062838.GN5891@holomorphy.com> <Pine.LNX.4.50.0303170226180.2229-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303170226180.2229-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Mar 2003, William Lee Irwin III wrote:
>> Well, I tried it in my prior attempt and didn't have problems in that
>> area. AFAICT it "just works" if you jack up the numbers.

On Mon, Mar 17, 2003 at 02:28:26AM -0500, Zwane Mwaikambo wrote:
> Cool i'm trying to get hold of some more SCSI HBAs and disks to put on 
> other nodes (plenty of FC but no drivers), i'll let you know how it goes.

On Sun, 16 Mar 2003, William Lee Irwin III wrote:
>> Also, NUMA-Q's max at 640 routeable RTE's with 16 quads so you'll only
>> need to add 1 to HARDIRQ_BITS.
>> The cpu count issue I've fixed in a separate patch.

On Mon, Mar 17, 2003 at 02:28:26AM -0500, Zwane Mwaikambo wrote:
> I'd have to rob a couple more poor souls to get 16 quads ;)

Getting them together in one place involves extreme pain/hassles.


-- wli
