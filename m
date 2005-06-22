Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262770AbVFVKGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbVFVKGc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 06:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbVFVKFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 06:05:52 -0400
Received: from ns.firmix.at ([62.141.48.66]:57729 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S262469AbVFVKE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 06:04:59 -0400
Subject: Re: [PATCH] Pointer cast warnings in scripts/
From: Bernd Petrovitsch <bernd@firmix.at>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Roman Zippel <zippel@linux-m68k.org>, kbuild-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <42B92D92.7070304@drzeus.cx>
References: <42B7F740.6000807@drzeus.cx>
	 <Pine.LNX.4.61.0506211413570.3728@scrub.home> <42B80AF9.2060708@drzeus.cx>
	 <Pine.LNX.4.61.0506211451040.3728@scrub.home> <42B80F40.8000609@drzeus.cx>
	 <1119359653.18845.55.camel@tara.firmix.at> <42B92D92.7070304@drzeus.cx>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 22 Jun 2005 12:04:20 +0200
Message-Id: <1119434660.2894.47.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-22 at 11:21 +0200, Pierre Ossman wrote:
> Bernd Petrovitsch wrote:
> >The C-standard about "char", "signed char" and "unsigned char"?
> >These are 3 different types.
> 
> I was referring to which of the three types is correct for str*().

"char" as one can read in every man-page.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

