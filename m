Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261745AbSJUG6i>; Mon, 21 Oct 2002 02:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262617AbSJUG6i>; Mon, 21 Oct 2002 02:58:38 -0400
Received: from ulima.unil.ch ([130.223.144.143]:1664 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S261745AbSJUG6i>;
	Mon, 21 Oct 2002 02:58:38 -0400
Date: Mon, 21 Oct 2002 09:04:44 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44 Oops (ISDN)
Message-ID: <20021021070444.GA2917@ulima.unil.ch>
References: <20021020171306.GA15607@ulima.unil.ch> <Pine.LNX.4.44.0210202127380.25262-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0210202127380.25262-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 09:29:58PM -0500, Kai Germaschewski wrote:

> > (syncppp don't compil already reported)
> 
> Yup, that's known, I'm working on it.

Great ;-))

> Someone converted HiSax to struct workqueue, which is not really the right 
> fix, BTW, and messed up.
> 
> ISDN has been badly broken by removing various old-fashioned APIs, it'll 
> take a bit to stabilize again.

Thank you very much, I'll be more than happy to be able to use ISDN
under 2.5 :-)

Have a great day,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
