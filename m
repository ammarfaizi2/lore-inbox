Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133053AbRDUXdS>; Sat, 21 Apr 2001 19:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133054AbRDUXdI>; Sat, 21 Apr 2001 19:33:08 -0400
Received: from huizehofstee.xs4all.nl ([194.109.241.183]:62213 "EHLO
	server.hofstee") by vger.kernel.org with ESMTP id <S133053AbRDUXc5>;
	Sat, 21 Apr 2001 19:32:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Victor Julien <v.p.p.julien@let.rug.nl>
Organization: Huize Hofstee
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3+ sound distortion
Date: Sun, 22 Apr 2001 01:31:11 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <E14r6ax-0004Xw-00@the-village.bc.nu>
In-Reply-To: <E14r6ax-0004Xw-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01042201311102.00380@victor>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 April 2001 01:15, you wrote:
> > I have a problem with kernels higher than 2.4.2, the sound distorts when
> > playing a song with xmms while the seti@home client runs. 2.4.2 did not
> > have this problem. I tried 2.4.3, 2.4.4-pre5 and 2.4.3-ac11. They al
> > showed the same problem.
>
> The 2.4.3->2.4.3-ac kernels include workarounds for the VIA chipset
> corruption reports. It is possible these have an impact, paticularly if the
> programs are making heavy use of X11.
>
> Can you describe the 'distortion' better - clicking, bits repeated ?

The distortion is noise in the music. The music does not stutter or stop. 
It's a high-toned noise in the music. It's not there every second, but on 
average 30 seconds in every minute. It seems to be dependand on the kind of 
calcultions seti is making.

The noise seems to have nothing to do with X11, because in console mode 
running the seti client and mpg123, results in exactly the same noiselevel as 
in X11.

I've tried 2.4.3-pre{3,4,6}, 2.4.3, 2.4.4-pre5 and 2.4.3-ac11, they al have 
the problem. Only 2.4.3-pre{1,2} did not. 2.4.2 has also no problems.


Victor Julien



Please put my email-adres in CC, when responding.
