Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314463AbSD0Uao>; Sat, 27 Apr 2002 16:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314505AbSD0Uan>; Sat, 27 Apr 2002 16:30:43 -0400
Received: from holomorphy.com ([66.224.33.161]:30915 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314463AbSD0Uan>;
	Sat, 27 Apr 2002 16:30:43 -0400
Date: Sat, 27 Apr 2002 13:29:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] linux-2.4.19-pre7-rmap13
Message-ID: <20020427202935.GQ21206@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Teodor Iacob <Teodor.Iacob@astral.kappa.ro>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020427085425.GA5573@linux.kappa.ro> <20020427150643.GP21206@holomorphy.com> <20020427191431.GA15010@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 10:14:31PM +0300, Teodor Iacob wrote:
> I discovered the oops and the bug message by typing dmesg,
> and the system was running well, I just saw the messages
> in the logs, and the order was the BUG and then the oops.
> I attached the .config used .. hope it helps

Okay, nothing stands out there, could you by chance strace hlds to
see what kind of socketcall it's doing, and maybe send some of the
strace output to me in a private reply?


Thanks,
Bill
