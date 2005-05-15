Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVEOHE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVEOHE2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 03:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVEOHEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 03:04:22 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:25005 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S261538AbVEOHES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 03:04:18 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Edgar Toernig <froese@gmx.de>
Subject: Re: Automatic .config generation
Date: Sun, 15 May 2005 09:03:42 +0200
User-Agent: KMail/1.7.2
Cc: jmerkey <jmerkey@utah-nac.org>, Scott Robert Ladd <lkml@coyotegulch.com>,
       linux-kernel@vger.kernel.org
References: <42839AF7.4030708@coyotegulch.com> <42838D4C.3040207@utah-nac.org> <20050512231726.6198bbc6.froese@gmx.de>
In-Reply-To: <20050512231726.6198bbc6.froese@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505150903.42212.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 May 2005 23:17, Edgar Toernig wrote:
> jmerkey wrote:
> > Scott Robert Ladd wrote:
> > >Is there a utility that creates a .config based on analysis of the
> > >target system?
> >
> > Now that's a great idea ..... :-)
>
> Not really new though :-)
>
>     http://sourceforge.net/projects/kautoconfigure/
>
> Ciao, ET.

how about /proc/config.gz.. although this was pretty recent IIRC.

Regards,
Boris.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
