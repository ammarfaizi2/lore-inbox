Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbUAFQ76 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 11:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUAFQ76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 11:59:58 -0500
Received: from findaloan.ca ([66.11.177.6]:19176 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S262127AbUAFQ7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 11:59:55 -0500
Date: Tue, 6 Jan 2004 10:00:41 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040106150041.GB10971@mark.mielke.cc>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	Greg KH <greg@kroah.com>
References: <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105132756.A975@pclin040.win.tue.nl> <Pine.LNX.4.58.0401050749490.21265@home.osdl.org> <20040105205228.A1092@pclin040.win.tue.nl> <Pine.LNX.4.58.0401051224480.2153@home.osdl.org> <20040106001326.A1128@pclin040.win.tue.nl> <Pine.LNX.4.58.0401051522390.5737@home.osdl.org> <20040106020648.A1153@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040106020648.A1153@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 02:06:48AM +0100, Andries Brouwer wrote:
> On Mon, Jan 05, 2004 at 03:32:03PM -0800, Linus Torvalds wrote:
> > > Something reproducible is better.
> > And I've told you why reproducibility is a BAD THING
> > Basically, if you cannot 100% guarantee reproducibility,
> > then the _appearance_ of reproducibility is literally a mistake.
> OK. We now understand perfectly each others point of view.
> It was a pleasure to provoke this discussion - can hardly
> wait for 2.7 :-)

Hehe.... s/provoke/perpetuate/g

Cheers,
mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

