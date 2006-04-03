Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWDCOHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWDCOHB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 10:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWDCOHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 10:07:01 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:27844 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751133AbWDCOHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 10:07:00 -0400
Date: Mon, 3 Apr 2006 16:06:54 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Remove unused exports and save 98Kb of kernel size
Message-ID: <20060403140654.GB12873@wohnheim.fh-wedel.de>
References: <1143925545.3076.35.camel@laptopd505.fenrus.org> <1143926338.18439.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1143926338.18439.3.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 April 2006 23:18:58 +0200, Marcel Holtmann wrote:
> 
> > I've made a patch to remove all EXPORT_SYMBOL's that aren't used in the
> > kernel; it's too big for the list so it can be found at
> > 
> > http://www.kernelmorons.org/unexport.patch
> 
> no ack for net/bluetooth/ from me.

Why not?  Do you have patches pending for submission that will use
those exported symbols?

Jörn

-- 
The strong give up and move away, while the weak give up and stay.
-- unknown
