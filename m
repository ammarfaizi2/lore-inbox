Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289106AbSAVAiu>; Mon, 21 Jan 2002 19:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289109AbSAVAi2>; Mon, 21 Jan 2002 19:38:28 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:33376 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289106AbSAVAiP>; Mon, 21 Jan 2002 19:38:15 -0500
Date: Tue, 22 Jan 2002 01:39:09 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@zip.com.au, reid.hekman@ndsu.nodak.edu, linux-kernel@vger.kernel.org,
        alan@lxorg.ukuu.org
Subject: Re: Athlon PSE/AGP Bug
Message-ID: <20020122013909.N8292@athlon.random>
In-Reply-To: <20020121.053724.124970557.davem@redhat.com> <20020121175410.G8292@athlon.random> <3C4C5B26.3A8512EF@zip.com.au> <20020121.142320.123999571.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020121.142320.123999571.davem@redhat.com>; from davem@redhat.com on Mon, Jan 21, 2002 at 02:23:20PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 02:23:20PM -0800, David S. Miller wrote:
>    From: Andrew Morton <akpm@zip.com.au>
>    Date: Mon, 21 Jan 2002 10:17:10 -0800
> 
>    Andrea Arcangeli wrote:
>    > I think this is a very very minor issue, I doubt anybody ever triggered
>    > it in real life with linux.
>    
>    It is said that the crashes cease when the `nopentium' option
>    is used, so it does appear that something is up.
>    
>    I does seem that the nVidia driver is usually involved.
> 
> I think this is all "just so happens" personally, and all the that
> turning off the large pages really does is change the timings so that
> whatever bug is really present simply becomes a heisenbug.

My same wondering, however I wasn't sure how much the timing could
really change to make the kernel bugs trigger.

Andrea
