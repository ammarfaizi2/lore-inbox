Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264039AbUDVN6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbUDVN6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 09:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbUDVN6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 09:58:54 -0400
Received: from mail.enyo.de ([212.9.189.167]:25607 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S264039AbUDVN6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 09:58:52 -0400
To: hadi@cyberus.ca
Cc: Giuliano Pochini <pochini@shiny.it>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       cfriesen@nortelnetworks.com,
       =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
References: <XFMail.20040422102359.pochini@shiny.it>
	<1082640135.1059.93.camel@jzny.localdomain>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Thu, 22 Apr 2004 15:58:40 +0200
In-Reply-To: <1082640135.1059.93.camel@jzny.localdomain> (hadi@cyberus.ca's
 message of "22 Apr 2004 09:22:16 -0400")
Message-ID: <87zn94w1v3.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal <hadi@cyberus.ca> writes:

> OTOH, long lived BGP sessions are affected assuming you are going across
> hostile path to your peer.

Hostile path is not required.  Not at all. 8-(

And it's not BGP specific.  You might be able to use this attack to
split IRC networks, too.  However, it's a bit harder in this case
because IRC servers usually use more random source ports.

-- 
Current mail filters: many dial-up/DSL/cable modem hosts, and the
following domains: atlas.cz, bigpond.com, postino.it, tiscali.co.uk,
tiscali.cz, tiscali.it, voila.fr.
