Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281754AbRLAXsB>; Sat, 1 Dec 2001 18:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282499AbRLAXrw>; Sat, 1 Dec 2001 18:47:52 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:65213 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281754AbRLAXrg>; Sat, 1 Dec 2001 18:47:36 -0500
Date: Sat, 1 Dec 2001 16:47:40 -0700
Message-Id: <200112012347.fB1NleW03464@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <3C093F86.DA02646D@wanadoo.fr>
In-Reply-To: <3C085FF3.813BAA57@wanadoo.fr>
	<9u9qas$1eo$1@penguin.transmeta.com>
	<200112010701.fB171N824084@vindaloo.ras.ucalgary.ca>
	<3C0898AD.FED8EF4A@wanadoo.fr>
	<200112011836.fB1IaxY31897@vindaloo.ras.ucalgary.ca>
	<3C093F86.DA02646D@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I should also point out that you need to compile with
CONFIG_DEVFS_DEBUG=y. Otherwise passing "devfs=dall" will have no
effect.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
