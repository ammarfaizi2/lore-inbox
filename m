Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129529AbRCPNdC>; Fri, 16 Mar 2001 08:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129568AbRCPNcx>; Fri, 16 Mar 2001 08:32:53 -0500
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:40965 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129529AbRCPNcj>; Fri, 16 Mar 2001 08:32:39 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Nick.Holloway@pyrites.org.uk (Nick Holloway)
Newsgroups: list.linux-kernel
Subject: Re: [PATCH] Improved version reporting
Date: 16 Mar 2001 13:30:53 -0000
Organization: Alfie's Internet Node
Message-ID: <98t4id$5la$1@alfie.demon.co.uk>
In-Reply-To: <UTC200103161245.NAA00944.aeb@vlet.cwi.nl>
X-Newsreader: NN version 6.5.0 CURRENT #119
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl writes:
>     From: Riley Williams <rhw@MemAlpha.CX>
>     {Shrug} Please explain why I was unable to get ver_linux to report a
> 
>   % ./loadkeys -h 2>&1 | head -1
>   loadkeys version 1.06
> 
> Maybe nothing has changed here the past eight years. It just works.
> Perhaps you tried some modified version.

Debian 2.2 has loadkeys from a console-tools package, which can be found
at http://lct.sourceforge.net/

    $ loadkeys --version
    loadkeys: (console-tools) 0.2.3

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
