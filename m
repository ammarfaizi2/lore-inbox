Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132048AbRACQsG>; Wed, 3 Jan 2001 11:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132109AbRACQrz>; Wed, 3 Jan 2001 11:47:55 -0500
Received: from copernicus.mpcnet.com.br ([200.246.29.18]:777 "EHLO
	copernicus.mpcnet.com.br") by vger.kernel.org with ESMTP
	id <S132048AbRACQrf>; Wed, 3 Jan 2001 11:47:35 -0500
To: linux-kernel@vger.kernel.org
Subject: VIA system timer (problem still in test13-pre7 and prerelease)
Reply-To: Jeronimo Pellegrini <jeronimo@ic.unicamp.br>
From: Jeronimo Pellegrini <jeronimo@ic.unicamp.br>
Date: 03 Jan 2001 14:14:09 -0200
In-Reply-To: Vojtech Pavlik's message of "Thu, 26 Oct 2000 15:33:26 +0200"
Message-ID: <86vgrwvcj2.fsf@mpcnet.com.br>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello.

Some time ago, Vojtech Pavlik sent a message stating that he had found
a critical bug in some VIA chipsets, and suggested a patch.

The bug would "cause X to blank the screen when it should not, squid
to terminate connections with a 'timeout' randomly and other nice
effects."

The problem is still present in test13-pre7 and in prerelease; X
blanks like crazy sometimes here, and applying the patch solves the
problem nicely here. This is a VIA Apollo Pro 133 system
(VIA 693/596B)

Not sure why it didn't go into the main tree, and since there's
prerelease out there, I thought I'd send this message. (Were there
problems with that patch?)

J.

-- 
Jeronimo Pellegrini
Institute of Computing - Unicamp - Brazil
http://www.ic.unicamp.br/~jeronimo
mailto:jeronimo@ic.unicamp.br    mailto:pellegrini@iname.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
