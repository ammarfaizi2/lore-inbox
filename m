Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136605AbRAHGfe>; Mon, 8 Jan 2001 01:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136858AbRAHGfZ>; Mon, 8 Jan 2001 01:35:25 -0500
Received: from Cantor.suse.de ([194.112.123.193]:44560 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S136605AbRAHGfO>;
	Mon, 8 Jan 2001 01:35:14 -0500
Date: Mon, 8 Jan 2001 07:35:12 +0100
From: Andi Kleen <ak@suse.de>
To: Paul Cassella <pwc@speakeasy.net>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: 2.4.0-ac3 write() to tcp socket returning errno of -3 (ESRCH: "No such process")
Message-ID: <20010108073512.A29905@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0101072217440.703-100000@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101072217440.703-100000@localhost>; from pwc@speakeasy.net on Sun, Jan 07, 2001 at 11:55:28PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 11:55:28PM -0600, Paul Cassella wrote:
> [1.] One line summary of the problem:    
> 
> write() returns -1 and sets errno non-sensically.  2.4.0{,-ac[23]}


Would it be possible to provide a compiling test case that shows these
errors ? 


Also over what interface do you run it? 


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
