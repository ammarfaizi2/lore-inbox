Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130286AbQKIOhQ>; Thu, 9 Nov 2000 09:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130889AbQKIOhH>; Thu, 9 Nov 2000 09:37:07 -0500
Received: from Cantor.suse.de ([194.112.123.193]:17935 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130286AbQKIOgv>;
	Thu, 9 Nov 2000 09:36:51 -0500
Date: Thu, 9 Nov 2000 15:36:48 +0100
From: Andi Kleen <ak@suse.de>
To: david <sector2@ihug.co.nz>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: fpu now a must in kernel
Message-ID: <20001109153648.A21769@gruyere.muc.suse.de>
In-Reply-To: <3A09E161.ACB11253@ihug.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A09E161.ACB11253@ihug.co.nz>; from sector2@ihug.co.nz on Thu, Nov 09, 2000 at 12:27:29PM +1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2000 at 12:27:29PM +1300, david wrote:
> 
> 2 . put the save / restore code in my code (NOT! GOOD! i do not wont to
> do it this way it is not the right way)

It is the right way because it only penalizes your code, not everybody else.

A
-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
