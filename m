Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270430AbTHCEoV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 00:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270475AbTHCEoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 00:44:21 -0400
Received: from hank-fep8-0.inet.fi ([194.251.242.203]:36022 "EHLO
	fep08.tmt.tele.fi") by vger.kernel.org with ESMTP id S270430AbTHCEoT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 00:44:19 -0400
From: Pasi Savilaakso <pasi.savilaakso@pp.inet.fi>
Organization: Linsystems
To: Nuno Monteiro <nuno@itsari.org>
Subject: Re: audio problem with 2.4.22-pre10 and 2.4.22-pre10-ac1
Date: Sun, 3 Aug 2003 07:46:34 +0300
User-Agent: KMail/1.5.2
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <200308021031.57014.pasi.savilaakso@pp.inet.fi> <20030802121921.GA2023@hobbes.itsari.int>
In-Reply-To: <20030802121921.GA2023@hobbes.itsari.int>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200308030746.38829.pasi.savilaakso@pp.inet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Viestissä Lauantai 2. Elokuuta 2003 15:19, Nuno Monteiro kirjoitti:

> Hi Pasi,
>
>
> I have a similar board lying around and I had some trouble getting sound
> to work with OSS/2.4 drivers also. As I remember. the trick was to
> connect the speakers to the microphone port (the pink one, on the far
> left), instead of the regular speaker-out. With ALSA, both on 2.4 or
> 2.5/6, the sound output is on the speaker-out port, as it should. One
> small quirk though, as the sound volume is controled by the "Surround"
> mixer setting, rather than "Master" -- this has the most annoying effect
> of making the sound-volume task bar applets useless. Eventually I just
> gave up on the on-board sound and plugged in a pci soundblaster.
>
> Hope this can help you.

Thanks for the tip but It wasn't the solution. all 3 lines out are dead. It is 
shame since I sold my sblive a while back.

Pasi 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/LJOuCATNOy4O2C4RAlZFAKDCeR6dHcLYR9j7ro7ZicsIxEntnQCfbzJ7
CsI/+8jx6u0/G1IZam+XaYI=
=gyaq
-----END PGP SIGNATURE-----


