Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUFJMzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUFJMzz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 08:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUFJMzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 08:55:55 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:11940 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261206AbUFJMzy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 08:55:54 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Lars <terraformers@gmx.net>
Subject: Re: 2.6.7-rc3: nforce2, no C1 disconnect fixup applied
Date: Thu, 10 Jun 2004 14:59:45 +0200
User-Agent: KMail/1.5.3
References: <ca9jj9$dr$1@sea.gmane.org>
In-Reply-To: <ca9jj9$dr$1@sea.gmane.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406101459.45750.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Do you get lockups with -rc3 and not with -rc2?

On Thursday 10 of June 2004 14:18, Lars wrote:
> hello
>
> problem with 2.6.7-rc3 and asus a7n8x nforce2 board is here that
> the C1 disconnect fix is not applied anymore after booting.
> -rc2 worked OK without any lockups.
> i understand that the new fix in -rc3 checks an bios option
> to enable the fixup but the a7n8x bios does not have such option.
> so it would be nice to have the possibility to force the fixup, because
> it worked really fine here before.
>
> thanks,
> lars

