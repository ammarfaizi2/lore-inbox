Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTKHTU6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 14:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTKHTU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 14:20:58 -0500
Received: from mother.ds.pg.gda.pl ([153.19.213.213]:61824 "HELO
	mother.ds.pg.gda.pl") by vger.kernel.org with SMTP id S262063AbTKHTU5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 14:20:57 -0500
Date: Sat, 8 Nov 2003 20:21:13 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: bert hubert <ahu@ds9a.nl>, Maciej Zenczykowski <maze@cela.pl>
Subject: Re: Syscalls being obsoleted???
Message-ID: <20031108192112.GA2144@irc.pl>
Mail-Followup-To: Tomasz Torcz <zdzichu@irc.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bert hubert <ahu@ds9a.nl>, Maciej Zenczykowski <maze@cela.pl>
References: <Pine.LNX.4.44.0311071236110.26063-100000@gaia.cela.pl> <20031108114909.GA21937@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031108114909.GA21937@outpost.ds9a.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Nov 07, 2003 at 12:39:16PM +0100, Maciej Zenczykowski wrote:
> > I read somewhere that (all) syscalls (as in the method of calling them) 
> > are being obsoleted, unfortunately this makes for a rather poor search 
> > term.
> > Thus the question: is this true and with what is this being replaced?  
> > [just a link would be sufficient]

I think that he meant this phrase in post-halloween-2.5.txt:
#v+
- Calling syscalls by numeric values is deprecated, and will go away
  in the next development series.
#v-

What is new way of calling syscalls?

-- 
Tomasz Torcz                Only gods can safely risk perfection,     
zdzichu@irc.-nie.spam-.pl     it's a dangerous thing for a man.  -- Alia
|> Playing: stream4.jungletrain.net:8000 ...
