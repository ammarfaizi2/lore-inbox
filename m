Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWBWNCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWBWNCQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 08:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWBWNCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 08:02:16 -0500
Received: from ezoffice.mandriva.com ([84.14.106.134]:44042 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP
	id S1751180AbWBWNCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 08:02:15 -0500
From: Thierry Vignaud <tvignaud@mandriva.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc4-mm1
Organization: Mandrakesoft
References: <20060220042615.5af1bddc.akpm@osdl.org>
	<43FC6B8F.4060601@ums.usu.ru> <43FC8290.8070408@ums.usu.ru>
	<1140696659.19361.13.camel@localhost.localdomain>
X-URL: <http://www.linux-mandrake.com/
Date: Thu, 23 Feb 2006 14:02:06 +0100
In-Reply-To: <1140696659.19361.13.camel@localhost.localdomain> (Alan Cox's
	message of "Thu, 23 Feb 2006 12:10:58 +0000")
Message-ID: <m2fymai5yp.fsf@vador.mandriva.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> The libata and pata_via in -mm are a bit out of date. The current
> libata patch and driver for 2.6.16-rc4 knows how to do per device
> modes.

does this include the other pata_* drivers?

