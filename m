Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263549AbTDGRFA (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 13:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263551AbTDGRFA (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 13:05:00 -0400
Received: from smtp01.web.de ([217.72.192.180]:57382 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263549AbTDGRE7 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 13:04:59 -0400
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: Sergei Organov <osv@javad.ru>
Subject: Re: modifying line state manually on ttyS
Date: Mon, 7 Apr 2003 19:16:16 +0200
User-Agent: KMail/1.5
References: <200304071702.08114.freesoftwaredeveloper@web.de> <200304071832.20627.freesoftwaredeveloper@web.de> <877ka6i6m1.fsf@osv.javad.ru>
In-Reply-To: <877ka6i6m1.fsf@osv.javad.ru>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304071916.16835.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 April 2003 19:01, Sergei Organov wrote:
> Michael Buesch <freesoftwaredeveloper@web.de> writes:
> > What does it do? I haven't found a description for TIOCSBRK, TIOCSBRK.
>
> Changes the state of TxD line, I believe. Did you hear about "break
> condition"? It sets/clears the "break condition", at least for me ;)

Oh my goodness, it works. Thank you *very* much!

Regards
Michael Buesch.

-- 
My homepage: http://www.8ung.at/tuxsoft
fighting for peace is like fu**ing for virginity

