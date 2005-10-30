Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVJ3Sch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVJ3Sch (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 13:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbVJ3Sch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 13:32:37 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:17601 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932197AbVJ3Scg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 13:32:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S31lJqE/mHoSASNit5BVEg79bYVR7QhVa54RxUUF3sbGID94irN+MobY2hldTR2eoWfrjDTMQo7IlEZdguc0gNkp/tW4ItF/XqEE84Nog/Y2Ut12fNiEy2QdZlEbOAZCtht3zlO2kK2DNpw6J8z0JVa/nYS7JNQR2A2TKi785M4=
Message-ID: <b2992ee70510301032h40741fbbhcab2741fd62559be@mail.gmail.com>
Date: Sun, 30 Oct 2005 19:32:35 +0100
From: Patrick Useldinger <uselpa@gmail.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: Fwd: segmentation fault when accessing /proc/ioports
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051030102212.679f35db.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b2992ee70510290209h26c1fd6ex92fd137cd2c9d747@mail.gmail.com>
	 <20051029110358.GI4180@stusta.de>
	 <b2992ee70510290422g1912d1e5sedcdf6fc0155c4b0@mail.gmail.com>
	 <20051029112617.GJ4180@stusta.de>
	 <b2992ee70510290736l7ec43091o880f141bd8be09e7@mail.gmail.com>
	 <b2992ee70510291004n66537b79h38c6d94005b82cf4@mail.gmail.com>
	 <20051030102212.679f35db.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/05, Randy.Dunlap <rdunlap@xenotime.net> wrote:

> Did you perhaps load and unload the (PCMCIA) i82365 driver module?

It's possible, the machine has a PCMCIA slot I never use.
But I haven't changed anything related to PCMCIA, so the problem
should still be there, but it isn't since I got rid of dm_mod.

> What's a VG?
A volume group, as used in the context of logical volumes and LVM2.

Regards,
-pu
