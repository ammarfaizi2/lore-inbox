Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262366AbSKCTDe>; Sun, 3 Nov 2002 14:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262368AbSKCTDe>; Sun, 3 Nov 2002 14:03:34 -0500
Received: from holomorphy.com ([66.224.33.161]:5008 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262366AbSKCTDd>;
	Sun, 3 Nov 2002 14:03:33 -0500
Date: Sun, 3 Nov 2002 11:08:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Margit Schubert-While <margit@margit.com>, linux-kernel@vger.kernel.org
Subject: Re: U160 on Adaptec 39160
Message-ID: <20021103190845.GK23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	Margit Schubert-While <margit@margit.com>,
	linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021103124403.00b4c860@mail.dns-host.com> <20021103133014.GJ23425@holomorphy.com> <3DC56EC1.4040403@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC56EC1.4040403@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> 39160 does 80MB/s/channel, the 160MB/s happens pretty much only as
>> the sum of both channels.

On Sun, Nov 03, 2002 at 10:45:21AM -0800, Dave Hansen wrote:
> Nope, quoting from Adaptec's site:
>> <snip>
>> enterprise servers. Combining a 64-bit PCI interface with two
>> Ultra160 SCSI channels, this card moves data at the fastest speeds
>> possible. <snip>
> The 3950 had dual 80MB/s channels.

Now consider the odds our victim^Wbugreporter has 64-bit PCI.


Bill
