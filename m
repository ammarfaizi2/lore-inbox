Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVANOwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVANOwX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 09:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVANOwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 09:52:23 -0500
Received: from mail.enyo.de ([212.9.189.167]:43446 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S262000AbVANOwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 09:52:21 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: jtjm@xenoclast.org (Julian T. J. Midgley)
Cc: linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	<1105643984.5193.95.camel@localhost.localdomain>
	<20050113204415.GF24970@beowulf.thanes.org>
	<20050114102249.GA3539@wiggy.net> <cs8cqv$jo5$1@sea.gmane.org>
Date: Fri, 14 Jan 2005 15:52:19 +0100
In-Reply-To: <cs8cqv$jo5$1@sea.gmane.org> (Julian T. J. Midgley's message of
	"Fri, 14 Jan 2005 12:10:07 +0000 (UTC)")
Message-ID: <871xcoxduk.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Julian T. J. Midgley:

>>vendor suffer from that as well. Suppose vendors learn of a problem in
>>a product they visibly use such as apache or rsync. If all vendors
>>suddenly update their versions or disable things that will be noticed as
>>well, so vendors can't do that.
>
> I don't buy that at all.  There are numerous reasons for updating
> programs or disabling things, of which fixing security holes is but
> one.

People used to monitor large name servers run by the in-crowd for
synchronous updates, to get advance notice of the existence of BIND
security holes.  AFAIK, it was a reliable indicator.
