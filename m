Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVJFKyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVJFKyf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 06:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVJFKyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 06:54:35 -0400
Received: from free.hands.com ([83.142.228.128]:24517 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S1750804AbVJFKyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 06:54:35 -0400
Date: Thu, 6 Oct 2005 11:54:28 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Nikita Danilov <nikita@clusterfs.com>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051006105428.GI10538@lkcl.net>
References: <20051005230309.GO10538@lkcl.net> <200510060306.j96365YK009019@inti.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510060306.j96365YK009019@inti.inf.utfsm.cl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 11:06:05PM -0400, Horst von Brand wrote:
> >  i just spent two hours helping a friend who wasn't familiar
> >  with the concept of "give root password for maintenance or
> >  press ctrl-d" they'd been pressing ctrl-d because it said so
> >  and now i'm going to have a 5-hour round-trip journey and possibly
> >  an overnight stay to sort out the mess.
> 
> Any suggestion for a better message?
 
 warnings about "continuing to use your system without
 repairing the filesystem will result in further filesystem
 damage, ultimately making your system completely unusable.
 DO NOT ignore this message and press ctrl-d in order to
 continue using your system unless you REALLY know what you
 are doing."

 that sort of thing would have stopped my friend in their
 tracks and got them to phone me.

 l.

