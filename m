Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbTKLIEk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 03:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbTKLIEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 03:04:40 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:35817 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S261746AbTKLIEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 03:04:38 -0500
Date: Wed, 12 Nov 2003 09:04:33 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-tes9-bk15 visor causes kernel NULL pointer dereference
Message-ID: <20031112080433.GK32094@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031111154558.GE27685@charite.de> <20031111210849.GA5691@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031111210849.GA5691@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH <greg@kroah.com>:
> On Tue, Nov 11, 2003 at 04:45:58PM +0100, Ralf Hildebrandt wrote:
> > Yes, my kernel is tainted because of the nvdia module.
> 
> Can you try it without the nvidia module?

Will do today.

> Also, can you enable debugging in the visor driver by loading it with:
> 	modprobe visor debug=1

OK.

> and try it again and send me the kernel debug log?

Yes.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
Referat V a - Kommunikationsnetze -             AIM.  ralfpostfix
