Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbTDHU6y (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 16:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbTDHU6y (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 16:58:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51721 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261839AbTDHU6x (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 16:58:53 -0400
Message-ID: <3E933AB2.8020306@zytor.com>
Date: Tue, 08 Apr 2003 14:10:10 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Jes Sorensen <jes@wildopensource.com>, Martin Hicks <mort@bork.org>,
       linux-kernel@vger.kernel.org, wildos@sgi.com
Subject: Re: [patch] printk subsystems
References: <20030407201337.GE28468@bork.org> <20030408184109.GA226@elf.ucw.cz> <m3k7e4ycys.fsf@trained-monkey.org> <20030408210251.GA30588@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20030408210251.GA30588@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Well, I think we should first kill all crappy messages -- that
> benefits everyone. I believe that if we kill all unneccessary
> (carrying no information  except perhaps copyright or advertising)
> will help current problem a lot.
> 

That may sometimes be true, but a few things may be useful to be able to
turn back on.

	-hpa


