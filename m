Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWETPtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWETPtz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 11:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWETPtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 11:49:55 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:64392 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751231AbWETPty
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 11:49:54 -0400
Message-ID: <446F3AA0.7020904@drzeus.cx>
Date: Sat, 20 May 2006 17:49:52 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org,
       ppisa4lists@pikron.com
Subject: Re: Was this really supposed to go in?
References: <446F3788.8050105@drzeus.cx> <20060520154558.GB16679@flint.arm.linux.org.uk>
In-Reply-To: <20060520154558.GB16679@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> It's part of transitioning the data transfers over to taking the byte
> size instead of the log2 byte size.
>   

As long as it's a complete move and not having both, then I'm all for it.

> Well, I can't do anything about it now - I'm going away for a couple
> of weeks from tomorrow morning.
>
>   

The patch doesn't really break anything as the only two users make sure
the parameters are in sync, so it's no rush. Just make sure it's on your
list when you get back. ;)

Rgds
Pierre

