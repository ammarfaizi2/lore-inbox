Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287886AbSAUTMC>; Mon, 21 Jan 2002 14:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287894AbSAUTLx>; Mon, 21 Jan 2002 14:11:53 -0500
Received: from dlezb.ext.ti.com ([192.91.75.132]:2221 "EHLO go4.ext.ti.com")
	by vger.kernel.org with ESMTP id <S287886AbSAUTLd>;
	Mon, 21 Jan 2002 14:11:33 -0500
Subject: Re: Athlon PSE/AGP Bug
From: Harold Campbell <hcamp@muerte.net>
Reply-To: hcamp@muerte.net
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C4C5B26.3A8512EF@zip.com.au>
In-Reply-To: <1011610422.13864.24.camel@zeus>
	<20020121.053724.124970557.davem@redhat.com>,
	<20020121.053724.124970557.davem@redhat.com>; from davem@redhat.com on Mon,
	Jan 21, 2002 at 05:37:24AM -0800 <20020121175410.G8292@athlon.random> 
	<3C4C5B26.3A8512EF@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 21 Jan 2002 13:11:38 -0600
Message-Id: <1011640298.28651.34.camel@pcp117956pcs>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-21 at 12:17, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > ...
> > 
> > I think this is a very very minor issue, I doubt anybody ever triggered
> > it in real life with linux.
> 
> It is said that the crashes cease when the `nopentium' option
> is used, so it does appear that something is up.
> 
> I does seem that the nVidia driver is usually involved.
> 

If it makes any difference the only time my Athlon Thunderbird system
with Matrox G450 locks up is during quake3. No "nVidia inside(tm)".
Guess I'll toss in the nopentium option and see if it helps.

-- 
Some circumstantial evidence is very strong, as when you find a trout in
the milk.
		-- Thoreau

