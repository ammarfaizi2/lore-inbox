Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261402AbTCJS2m>; Mon, 10 Mar 2003 13:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261403AbTCJS2m>; Mon, 10 Mar 2003 13:28:42 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:55056 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261402AbTCJS2k>; Mon, 10 Mar 2003 13:28:40 -0500
Date: Mon, 10 Mar 2003 19:39:17 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries Brouwer <aebr@win.tue.nl>
cc: Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: struct inode size reduction.
In-Reply-To: <20030310173219.GA4152@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0303101907040.5042-100000@serv>
References: <20030309135402.GB32107@suse.de> <20030309171314.GA3783@win.tue.nl>
 <20030309203359.GA7276@suse.de> <20030309195555.A22226@infradead.org>
 <20030309203144.GA3814@win.tue.nl> <Pine.LNX.4.44.0303092310470.32518-100000@serv>
 <20030309230824.GA3842@win.tue.nl> <Pine.LNX.4.44.0303101100250.5042-100000@serv>
 <20030310120534.GA4125@win.tue.nl> <Pine.LNX.4.44.0303101620020.5042-100000@serv>
 <20030310173219.GA4152@win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Mar 2003, Andries Brouwer wrote:

> You see a future and ask why I don't jump to the future you
> see. The answer is that I take small steps.

Oh, I agree with small steps, but you should be damned careful with 
temporary interfaces, they have the bad habit of spreading and the more we 
have to cleanup later.
First we need a clean core, than we can start removing the current crap 
properly.

bye, Roman


