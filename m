Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283005AbRK1CTE>; Tue, 27 Nov 2001 21:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283007AbRK1CSy>; Tue, 27 Nov 2001 21:18:54 -0500
Received: from holomorphy.com ([216.36.33.161]:22448 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S283005AbRK1CSi>;
	Tue, 27 Nov 2001 21:18:38 -0500
Date: Tue, 27 Nov 2001 18:18:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] earlier printk output
Message-ID: <20011127181817.B3921@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011127180342.A3921@holomorphy.com> <3C044816.D6DCD2D3@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3C044816.D6DCD2D3@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, Nov 27, 2001 at 09:12:38PM -0500
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Included are i386 config options, early VGA text output, and early i386
>> serial output.

On Tue, Nov 27, 2001 at 09:12:38PM -0500, Jeff Garzik wrote:
> nice.  these patches work on some non-x86 platforms too...

I would be much obliged to hear of success running on other platforms,
and to integrate config options for them as well.

My testing for this specific patch has been limited to i386. I intend
to confer with IA64 maintainers for that platform, as a different
approach is currently in use there.


Thanks,
Bill
