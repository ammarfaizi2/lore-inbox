Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWCLD2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWCLD2o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 22:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWCLD2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 22:28:44 -0500
Received: from bee.hiwaay.net ([216.180.54.11]:20635 "EHLO bee.hiwaay.net")
	by vger.kernel.org with ESMTP id S1751030AbWCLD2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 22:28:43 -0500
Date: Sat, 11 Mar 2006 21:28:40 -0600
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.16-rc6
Message-ID: <20060312032840.GA1165818@hiwaay.net>
References: <fa.B/Q39e5tdKA8fofqhtAW7OLh/1U@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060311.183904.71244086.davem@davemloft.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, David S. Miller <davem@davemloft.net> said:
>> TCP: Treason uncloaked! Peer 82.113.55.2:11759/50967 shrinks window
>> 148470938:148470943. Repaired.
>
>It is a problem with the remote TCP implementation, it is
>illegally advertising a smaller window that it previously
>did.

Is this something that should be logged though?  I get these messages
all the time on my mirror server.  It isn't like I can do anything about
it.  If Linux is generous in what it accepts and can handle it, what is
the logged error for?
-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
