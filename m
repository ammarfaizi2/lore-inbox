Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290764AbSAYSTm>; Fri, 25 Jan 2002 13:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290761AbSAYST0>; Fri, 25 Jan 2002 13:19:26 -0500
Received: from ns.suse.de ([213.95.15.193]:63250 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290786AbSAYSTN>;
	Fri, 25 Jan 2002 13:19:13 -0500
Date: Fri, 25 Jan 2002 19:19:09 +0100
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        Richard Gooch <rgooch@atnf.csiro.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH]: Fix MTRR handling on HT CPUs (improved)
Message-ID: <20020125191908.K28068@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
	Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
	Richard Gooch <rgooch@atnf.csiro.au>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.33.0201241338030.15092-100000@penguin.transmeta.com> <E16UAmA-00038O-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16UAmA-00038O-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 25, 2002 at 06:08:34PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 06:08:34PM +0000, Alan Cox wrote:
 > 2.4 has a nice clean 2 line patch in to cover this or should have done
 > providing it didnt get lost in the merge.

 The microcode driver fix was ~2 lines. The MTRR ones I've seen
 have been a little more involved. Unless you saw something I
 didn't..
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
