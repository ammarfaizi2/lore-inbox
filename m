Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932320AbWFDXi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWFDXi1 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 19:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWFDXi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 19:38:27 -0400
Received: from gw.openss7.com ([142.179.199.224]:15339 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S932320AbWFDXi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 19:38:27 -0400
Date: Sun, 4 Jun 2006 17:38:25 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Marty Leisner <leisner@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mixing cache size on xeon4's in smp system
Message-ID: <20060604173825.A28581@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Marty Leisner <leisner@rochester.rr.com>,
	linux-kernel@vger.kernel.org
References: <200606042317.k54NHfIS026034@dell2.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200606042317.k54NHfIS026034@dell2.home>; from leisner@rochester.rr.com on Sun, Jun 04, 2006 at 11:17:41PM +0000
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marty,

On Sun, 04 Jun 2006, Marty Leisner wrote:

> 	
> I have a 2.4 gig hz xeon (533) with a 512k cache.
> Can I use a 2.4 gig xeon  (533) with a 1Mbyte cache in an smp configuration?

For most motherboards the answer is no, regardless of whether you
are running Linux or not.  For some motherboards, Xeons that vary
in lot number will not work with each other.  I suggest your first
consult someone that knows such things about your motherboard.
