Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbUCWJxd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 04:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbUCWJxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 04:53:32 -0500
Received: from aelfric.plus.com ([80.229.143.166]:46518 "EHLO zaphod.hmmn.org")
	by vger.kernel.org with ESMTP id S262415AbUCWJxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 04:53:30 -0500
Date: Tue, 23 Mar 2004 09:53:18 +0000
From: Jonathan Sambrook <swsusp@hmmn.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Message-ID: <20040323095318.GB20026@hmmn.org>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <20040318193703.4c02f7f5.akpm@osdl.org> <1079661410.15557.38.camel@calvin.wpcb.org.au> <20040318200513.287ebcf0.akpm@osdl.org> <1079664318.15559.41.camel@calvin.wpcb.org.au> <20040321220050.GA14433@elf.ucw.cz> <1079988938.2779.18.camel@calvin.wpcb.org.au> <20040322231737.GA9125@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322231737.GA9125@elf.ucw.cz>
Reply-By: Sat Mar 20 18:05:53 GMT 2004
X-OS: Linux 2.4.23 
X-Message-Flag: http://www.hmmn.org
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 00:17 on Tue 23/03/04, pavel@ucw.cz masquerading as 'Pavel Machek' wrote:
> Hi!
> 
> > > Now I have _proof_ that eye-candy is harmfull. What is see on screen is:
> > 
> > No, that's not proof; just a bug in the code. It's not using the right
> > code to display the error message. I'll fix it asap.
> 
> :-)
> 
> I'd really like eye-candy code to be gone. Its long, and its not worth
> the trouble.

Pejorative comments aside Pavel, it is valued feedback for end-user
re-assurance. It has also helped swsusp2 get streets ahead of the other
implementations by aiding end-user feedback on a wide range of hardware,
Which would appear to be well worth it? If it's not broke (and is
valuble) why rip it out?

Regards,
Jonathan


-- 


    .__
    |..|__   _____   _____   ___        ____  _    ____
    |;;|: \ /;:;:;\ /;:;:;\ /;:;\      /;;;;\/;\/\/;;;;\
    |   Y  \  Y Y  \  Y Y  \  Y  \    |  ___ \ |\_| ___ \
    |___|  /__|_|  /__|_|  /__|  /  o  \_____/ |  \___  /
         \/      \/      \/    \/            \/    _/  /
                                                   \__/
 
 hmmnsoft's FreeShade : window shading, for Windows, for free
 
                http://www.hmmn.org/FreeShade

