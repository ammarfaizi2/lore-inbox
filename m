Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVC1Tal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVC1Tal (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 14:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVC1Tal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 14:30:41 -0500
Received: from smtp7.wanadoo.fr ([193.252.22.24]:23255 "EHLO smtp7.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262016AbVC1Tab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 14:30:31 -0500
X-ME-UUID: 20050328193027774.BD0A81C000A5@mwinf0712.wanadoo.fr
Subject: Re: Various issues after rebooting
From: Olivier Fourdan <fourdan@xfce.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20050328192054.GV30052@alpha.home.local>
References: <1112039799.6106.16.camel@shuttle>
	 <20050328192054.GV30052@alpha.home.local>
Content-Type: text/plain
Organization: http://www.xfce.org
Date: Mon, 28 Mar 2005 21:30:26 +0200
Message-Id: <1112038226.6626.3.camel@shuttle>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy

On Mon, 2005-03-28 at 21:20 +0200, Willy Tarreau wrote:
> Now I have a compaq (nc8000) which does not exhibit such buggy behaviour,
> but you can try disabling the APIC too just in case it's a similar problem
> (at least in 32 bits, I don't know if you can disable it in 64 bits mode).

Thanks for the hint, but unfortunately, it's one of the first things I
tried, and that makes no difference.

Regards,
Olivier.



