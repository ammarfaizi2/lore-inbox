Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVFMM6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVFMM6S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 08:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVFMM6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 08:58:18 -0400
Received: from gs.bofh.at ([193.154.150.68]:27088 "EHLO gs.bofh.at")
	by vger.kernel.org with ESMTP id S261546AbVFMM6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 08:58:15 -0400
Subject: Re: udp.c
From: Bernd Petrovitsch <bernd@firmix.at>
To: Rommer <rommer@active.by>
Cc: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <42AD81FC.9020404@active.by>
References: <42AD74A3.1050006@active.by>
	 <1118664180.898.13.camel@tara.firmix.at>
	 <yw1xy89ebg14.fsf@ford.inprovide.com>
	 <1118666058.898.23.camel@tara.firmix.at>  <42AD81FC.9020404@active.by>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 13 Jun 2005 14:57:59 +0200
Message-Id: <1118667479.898.37.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 15:54 +0300, Rommer wrote:
> So, why BUG(), not just void function?

So that the kernel oopses and someone notices that serious breakage
immediately.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

