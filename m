Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264678AbUDVVP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264678AbUDVVP1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 17:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264680AbUDVVP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 17:15:27 -0400
Received: from mail.enyo.de ([212.9.189.167]:38409 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S264678AbUDVVP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 17:15:26 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: tcp vulnerability? haven't seen anything on it here...
References: <200404221738.i3MHcg7J005234@eeyore.valparaiso.cl>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Thu, 22 Apr 2004 23:15:21 +0200
In-Reply-To: <200404221738.i3MHcg7J005234@eeyore.valparaiso.cl> (Horst von
 Brand's message of "Thu, 22 Apr 2004 13:38:42 -0400")
Message-ID: <87r7ufu32u.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

> If everybody (or at least the bigger knots) filters spoofed traffic,
> this ceases to be a problem. And that solves a shipload of other
> problems, so...

There isn't much incentive to deploy filters so that other people
don't suffer.  So it takes a long time until it's almost universally
implemented.  (We catch less backscatter from DDoS attacks than a few
years ago, so the situation may actually be improving.)

-- 
Current mail filters: many dial-up/DSL/cable modem hosts, and the
following domains: atlas.cz, bigpond.com, postino.it, tiscali.co.uk,
tiscali.cz, tiscali.it, voila.fr.
