Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbTIDOnf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265089AbTIDOnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:43:35 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:24330 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S265086AbTIDOne
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:43:34 -0400
Date: Thu, 4 Sep 2003 15:43:32 +0100
From: John Levon <levon@movementarian.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] synclinkmp.c 2.4.23-pre3
Message-ID: <20030904144332.GA26973@compsoc.man.ac.uk>
References: <1062685785.2181.5.camel@diemos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062685785.2181.5.camel@diemos>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19uvKe-000Etb-HZ*9aTioyl6s8g*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 09:29:45AM -0500, Paul Fulghum wrote:

> * add MODULE_LICENSE() macro
> 
> Please apply

Why is it wrapped inside #ifdef MODULE_LICENSE ? It's in current 2.4 and
current 2.6, no ? When would it ever not be defined ?

regards
john

-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.
