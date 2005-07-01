Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263271AbVGAIRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbVGAIRL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 04:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263276AbVGAIRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 04:17:11 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:9491 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S263271AbVGAIQ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 04:16:59 -0400
Message-ID: <42C4FBF9.8080601@slaphack.com>
Date: Fri, 01 Jul 2005 03:16:57 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Markus T rnqvist <mjt@nysv.org>, Douglas McNaught <doug@mcnaught.org>,
       Hubert Chan <hubert@uhoreg.ca>, Kyle Moffett <mrmacman_g4@mac.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506291719.j5THJCSg011438@laptop11.inf.utfsm.cl>
In-Reply-To: <200506291719.j5THJCSg011438@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> Markus Törnqvist <mjt@nysv.org> wrote:
> 
> [...]
> 
> 
>>Note that MacOS has the monopoly on what they ship, Linux has a
>>motherload of file managers and window systems and all.
> 
> 
> Yep. Part of what is nice about it, too ;-)
> 
> 
>>What pisses me off is the fact that Gnome and friends implement
>>their own incompatible-with-others VFS's and automounters and
>>stuff.
> 
> 
> Then get them to agree on a common framework! They are trying hard to get
> other parts of the GUI work well together, so this isn't far off in
> wishfull thinking land.

Unfortunately, this leaves bash out in the cold, as usual.  Kernel-based 
automounter works with Bash.  Why can't GNOME/KDE use the kernel's one 
as at least one backend, even if they support others?
