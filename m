Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264813AbUDWNzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264813AbUDWNzo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 09:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264816AbUDWNzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 09:55:44 -0400
Received: from mail.enyo.de ([212.9.189.167]:22543 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S264813AbUDWNzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 09:55:43 -0400
To: hadi@cyberus.ca
Cc: Giuliano Pochini <pochini@shiny.it>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       cfriesen@nortelnetworks.com,
       =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
References: <XFMail.20040422102359.pochini@shiny.it>
	<1082640135.1059.93.camel@jzny.localdomain>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Fri, 23 Apr 2004 15:55:33 +0200
In-Reply-To: <1082640135.1059.93.camel@jzny.localdomain> (hadi@cyberus.ca's
 message of "22 Apr 2004 09:22:16 -0400")
Message-ID: <87u0zare7e.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal <hadi@cyberus.ca> writes:

> OTOH, long lived BGP sessions are affected assuming you are going across
> hostile path to your peer.

Jamal, please forget that "hostile path to your peer" part.  It's just
wrong.

You are entitled to your opinion that this isssue is being overhyped
(I tend to share it, at least until some evidence shows up that
there's also a 4.4BSD-like RST bug), but please try to understand the
issue before making any judgement.

-- 
Current mail filters: many dial-up/DSL/cable modem hosts, and the
following domains: atlas.cz, bigpond.com, postino.it, tiscali.co.uk,
tiscali.cz, tiscali.it, voila.fr.
