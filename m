Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132224AbRDJVgf>; Tue, 10 Apr 2001 17:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132301AbRDJVgY>; Tue, 10 Apr 2001 17:36:24 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:57475 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132224AbRDJVgO>;
	Tue, 10 Apr 2001 17:36:14 -0400
Message-ID: <3AD37CCD.DB0CCCD@mandrakesoft.com>
Date: Tue, 10 Apr 2001 17:36:13 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Manuel A. McLure" <mmt@unify.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Still IRQ routing problems with VIA
In-Reply-To: <419E5D46960FD211A2D5006008CAC79902E5C1A7@pcmailsrv1.sac.unify.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Manuel A. McLure" wrote:
> I'd do that if this wasn't also my Windows 98 gaming machine - I'm supposing
> that the Windows drivers do use the IRQ even if XFree86/Linux doesn't. I
> dunno if Windows is smart enough to assign an IRQ even if the BIOS doesn't.
> Anyway, things are working now (specially since the last tulip patches) and
> I like it that way :-)

Well, as the old saying goes, "if it ain't broke, don't fix it."

Theoretically, with PNP OS enabled, the driver will assign VGA an IRQ if
it needs one, under both Windows and Linux.

	Jeff


-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
