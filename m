Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265283AbRF0Gkm>; Wed, 27 Jun 2001 02:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265280AbRF0Gkd>; Wed, 27 Jun 2001 02:40:33 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:42762 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S265281AbRF0GkW>; Wed, 27 Jun 2001 02:40:22 -0400
Date: 27 Jun 2001 08:37:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <83fdx$Z1w-B@khms.westfalen.de>
In-Reply-To: <20010627014534.B2654@ondska>
Subject: Re: [PATCH] User chroot
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20010627014534.B2654@ondska>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jc@lysator.liu.se (Jorgen Cederlof)  wrote on 27.06.01 in <20010627014534.B2654@ondska>:

> If we only allow user chroots for processes that have never been
> chrooted before, and if the suid/sgid bits won't have any effect under
> the new root, it should be perfectly safe to allow any user to chroot.

Hmm. Dos this work with initrd and root pivoting?

MfG Kai
