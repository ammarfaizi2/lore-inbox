Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273619AbRJBM7C>; Tue, 2 Oct 2001 08:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273626AbRJBM6w>; Tue, 2 Oct 2001 08:58:52 -0400
Received: from ns.ithnet.com ([217.64.64.10]:61451 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S273619AbRJBM6n>;
	Tue, 2 Oct 2001 08:58:43 -0400
Date: Tue, 2 Oct 2001 14:59:02 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Stephen Frost <sfrost@snowman.net>
Cc: alan@whirlnet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.11-pre2
Message-Id: <20011002145902.5b74e5bf.skraw@ithnet.com>
In-Reply-To: <20011002085326.B29860@ns>
In-Reply-To: <Pine.LNX.4.33.0110011438230.990-100000@penguin.transmeta.com>
	<200110012218.f91MIGU10233@hswn.dk>
	<20011002125040.A10878@whirlnet.co.uk>
	<20011002143939.34e5cd62.skraw@ithnet.com>
	<20011002085326.B29860@ns>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2001 08:53:27 -0400 Stephen Frost <sfrost@snowman.net> wrote:

> * Stephan von Krawczynski (skraw@ithnet.com) wrote:
> > On Tue, 2 Oct 2001 12:50:40 +0100 Alan Ford <alan@whirlnet.co.uk> wrote:
> > 
> > > -	action_msg:	"Emergency Remount R/0\n",
> > > +	action_msg:	"Emergency Remount R/O\n",
> > 
> > What exactly do you want to fix with this patch?
> 
> 	That changes 'R/0' (R slash Zero) to R/O (R slash O).
> 	I think 'Read-Only' is what is meant in this 'action_msg'
> 	and is probably better represented with 'R/O' than 'R/0'.

Sorry for asking. I could not determine the difference in my on-screen font.

Regards,
Stephan

