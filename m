Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280201AbRKVR63>; Thu, 22 Nov 2001 12:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280948AbRKVR6J>; Thu, 22 Nov 2001 12:58:09 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:11482 "EHLO
	c0mailgw09.prontomail.com") by vger.kernel.org with ESMTP
	id <S280201AbRKVR6C>; Thu, 22 Nov 2001 12:58:02 -0500
Message-ID: <3BFD3C6B.B23D0A97@starband.net>
Date: Thu, 22 Nov 2001 12:56:59 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James A Sutherland <jas88@cam.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Swap vs No Swap.
In-Reply-To: <3BFC5A9B.915B77DF@starband.net> <E166rbB-0005LC-00@mauve.csi.cam.ac.uk> <3BFD2709.31A1A85E@starband.net> <E166xok-0000Nm-00@mauve.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for understanding!

James A Sutherland wrote:

> On Thursday 22 November 2001 4:25 pm, war wrote:
> > Why have SWAP if you don't need it - answer that.?
>
> Having it is supposed to improve performance. If you take two identical
> machines, and enable swap on one but not the other, the first machine should
> have better performance: it can cache the FS more effectively.
>
> Now, if you have INSANE amounts of RAM (i.e. enough to have everything
> running in RAM *AND* every file you access cached) the swap will make no
> difference at all. Under any other circumstances, it should make things
> better.
>
> James.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

