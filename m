Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbUBATLN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 14:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265405AbUBATLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 14:11:12 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:61191 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265201AbUBATLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 14:11:11 -0500
Date: Sun, 1 Feb 2004 20:20:08 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "olivier.serrano" <olivier.serrano@wanadoo.Fr>
Cc: mec@shout.net, linux-kernel@vger.kernel.org
Subject: Re: error message selecting advanced linux sound architecture
Message-ID: <20040201192008.GA3043@mars.ravnborg.org>
Mail-Followup-To: "olivier.serrano" <olivier.serrano@wanadoo.Fr>,
	mec@shout.net, linux-kernel@vger.kernel.org
References: <1075663299.2067.6.camel@routeur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075663299.2067.6.camel@routeur>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 08:21:40PM +0100, olivier.serrano wrote:
> Hello,
> 
> Could you please help ?
> when I select "advanced linux sound architecture"
> for the mandrake kernel 2.4.22-10mdk, i get the following
> error message :
> 
> Menuconfig has encountered a possible error in one of the kernel's
> configuration files and is unable to continue.  Here is the error
> report:
>                                                                                 
>  Q> scripts/Menuconfig: line 832: MCmenu78: command not found
> 

Known issue for a long time.
Go bug Mandrake - or search the archives. Pach fixing this has been posted
more than once.

	Sam
