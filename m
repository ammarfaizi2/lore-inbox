Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263295AbUEaKr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbUEaKr3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 06:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbUEaKr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 06:47:29 -0400
Received: from smtprelay04.ispgateway.de ([62.67.200.165]:18572 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S263295AbUEaKr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 06:47:27 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [patch - please comment] Support for UTF dead keys in 2.6
Date: Mon, 31 May 2004 11:23:02 +0200
User-Agent: KMail/1.6.2
References: <20040529143421.GA15127@ucw.cz> <200405310809.49059.ioe-lkml@rameria.de> <20040531063149.GD268@ucw.cz>
In-Reply-To: <20040531063149.GD268@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405311123.07203.ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Vojtech,

On Monday 31 May 2004 08:31, you wrote:
> > > ChangeSet@1.1610, 2004-05-03 12:38:37+02:00, vojtech@suse.cz
> > >   input: Make accent tables able to generate unicode characters. This
> > >          is needed for UTF8 console with multi-keystroke characters.
>
> Did you want to say anything?

Yes,
	1. My external editor setup was broken (kvim + kmail). Sorry
	   for this.

	2. Does your patch also support 2 diacritics per character?
	   This is a requirement for proper Vietnamese support.

Thanks and Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAuvl2U56oYWuOrkARAsxrAJ9hFGUojPeXG4CZ2w33x4rPzBMYfwCg4krL
uYNmM2L6iOIRy+0J4aYv8MI=
=nPtI
-----END PGP SIGNATURE-----
