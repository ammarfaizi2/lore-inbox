Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTIXHoa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 03:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbTIXHoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 03:44:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:24222 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262063AbTIXHo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 03:44:29 -0400
Date: Wed, 24 Sep 2003 09:44:27 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <20030923144951.03ae1ecb.akpm@osdl.org>
Subject: Re: [BUG] [2.6.0-test4] processes hung (reiserfs related?)
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <6315.1064389467@www53.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies to everyone! I was actually meaning 2.6.0-test5. A reiserfs
assertion was hitting me in test4.

> "Daniel Blueman" <daniel.blueman@gmx.net> wrote:
> >
> > I noticed 'ifconfig' hanging on my box, 
> 
> test4 is old; this should be fixed in current kernels.


-- 
Daniel J Blueman

NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

