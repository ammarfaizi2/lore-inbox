Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161196AbWF0RBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161196AbWF0RBH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161216AbWF0RBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:01:07 -0400
Received: from mx1.suse.de ([195.135.220.2]:4314 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161196AbWF0RBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:01:05 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       klibc@zytor.com, torvalds@osdl.org
Subject: Re: klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org>
	<Pine.LNX.4.64.0606271316220.17704@scrub.home>
	<44A13512.3010505@garzik.org>
From: Andi Kleen <ak@suse.de>
Date: 27 Jun 2006 19:01:03 +0200
In-Reply-To: <44A13512.3010505@garzik.org>
Message-ID: <p73r71attww.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> writes:
> 
> MD/DM root setup,

That would require pulling the tools for that into the kernel source right?
Not sure that's a good idea. Do you really want /usr/src/linux/liblvm ? 

-Andi
