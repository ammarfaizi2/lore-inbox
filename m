Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292700AbSCSVMM>; Tue, 19 Mar 2002 16:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292780AbSCSVLx>; Tue, 19 Mar 2002 16:11:53 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:39429 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S292700AbSCSVLs>;
	Tue, 19 Mar 2002 16:11:48 -0500
Date: Tue, 19 Mar 2002 14:12:31 -0700
From: yodaiken@fsmlabs.com
To: Pavel Machek <pavel@suse.cz>
Cc: yodaiken@fsmlabs.com, Linus Torvalds <torvalds@transmeta.com>,
        Andi Kleen <ak@suse.de>, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020319141231.A22305@hq.fsmlabs.com>
In-Reply-To: <20020316131219.C20436@hq.fsmlabs.com> <Pine.LNX.4.33.0203161223290.31971-100000@penguin.transmeta.com> <20020316143916.A23204@hq.fsmlabs.com> <20020319120618.GA470@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 01:06:19PM +0100, Pavel Machek wrote:
> Hammer is designed for desktop, AFAICT. [Its slightly modified athlon,
> you see?]

Thanks for the insight. Only by reading LKM could
I have found out that AMD doesn't care about server space.

