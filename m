Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266927AbSLWR1J>; Mon, 23 Dec 2002 12:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266928AbSLWR1J>; Mon, 23 Dec 2002 12:27:09 -0500
Received: from havoc.daloft.com ([64.213.145.173]:46530 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S266927AbSLWR1J>;
	Mon, 23 Dec 2002 12:27:09 -0500
Date: Mon, 23 Dec 2002 12:35:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Justin Cormack <justin@street-vision.com>
Cc: nick@snowman.net, Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       Sampson Fung <sampson@attglobal.net>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: Which Gigabit ethernet card?
Message-ID: <20021223173514.GA19833@gtf.org>
References: <Pine.LNX.4.21.0212230949270.22216-100000@ns.snowman.net> <1040664496.7156.112.camel@lotte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1040664496.7156.112.camel@lotte>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2002 at 05:28:11PM +0000, Justin Cormack wrote:
> er, no. GigE over copper autodetects crossovers, so a standard cable
> will work anyway. Actually this has been backported to some 100MB
> switches now (presumably use same io interfaces) so crossover cables are
> fast disappearing. You can even stick a non crossover cable between a
> 100MB pci card and a GigE one and it will work.

Yep.  This is called auto-polarity detection, FWIW.
