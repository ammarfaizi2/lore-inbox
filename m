Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269505AbRGaWRp>; Tue, 31 Jul 2001 18:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269506AbRGaWRf>; Tue, 31 Jul 2001 18:17:35 -0400
Received: from imladris.infradead.org ([194.205.184.45]:27657 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S269505AbRGaWRY>;
	Tue, 31 Jul 2001 18:17:24 -0400
Date: Tue, 31 Jul 2001 23:17:13 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Craig Milo Rogers <rogers@ISI.EDU>
cc: Matti Aarnio <matti.aarnio@zmailer.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OT: Virii on vger.kernel.org lists 
In-Reply-To: <22369.996603164@ISI.EDU>
Message-ID: <Pine.LNX.4.33.0107312312360.31582-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi Craig.

 >> Is there any way we can set up an automatic virus scan of all
 >> attachments at vger, and have it deal with any virii at source?

 > Better than that, simply strip all non-text MIME attachments, or
 > bounce the messages containing them.  End of story.

Two problems with that:

 1. Some virii are text attachments. Your fix doesn't deal wioth them.

 2. The maintainer of the XXX driver just uploaded a large patch that
    fixes a major bug in their driver to the mailing list, and zip'd
    it up to reduce its size. You just bounced it...

Basically, that particular fix causes pain and gives no gain, so as
far as I'm concerned, it's a non-starter...

Best wishes from Riley.

