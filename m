Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWEAVVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWEAVVQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWEAVVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:21:15 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:18153 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932263AbWEAVVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:21:14 -0400
Subject: Re: + drivers-scsi-use-array_size-macro.patch added to -mm tree
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tobias Klauser <tklauser@nuerscht.ch>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, linux-scsi@vger.kernel.org
In-Reply-To: <20060501203401.GA3557@neon.tklauser.home>
References: <200605011717.k41HHagU001787@shell0.pdx.osdl.net>
	 <1146505519.20760.60.camel@laptopd505.fenrus.org>
	 <20060501203401.GA3557@neon.tklauser.home>
Content-Type: text/plain
Date: Mon, 01 May 2006 14:16:04 -0700
Message-Id: <1146518164.3566.1.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 22:34 +0200, Tobias Klauser wrote:
> I probably should have mentioned the whitespace/coding style cleanups in
> the description of the patch. Or should I just leave out these kind of
> cleanups?

Just mentioning them in the changelog is best; that way no-one's
surprised about the areas the change touches.

Thanks,

James


