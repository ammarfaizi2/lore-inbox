Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVEaWsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVEaWsH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 18:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVEaWsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 18:48:07 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:51767 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261204AbVEaWsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 18:48:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=nPd3WWqeq6chG3hyw7Zd/RlnslGuqy3mcHhqegPAESAJMDnTJAd3r7oJCnp4cO5SBQR+zcatJG3GeQAH4n/r6vZOYYDMBUirSTH/O4hRwnJULZV0F4bsJGkJW8zShp1NxfFZrEnrXMIqriHeOO8w0QBOUB4+55YTzMcpCfBkdRo=
Date: Tue, 31 May 2005 23:37:12 +0200
From: Marcin Bis <marcin.bis@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: problem with ALSA ane intel modem driver
Message-ID: <20050531233712.7b782c6c@laptop>
In-Reply-To: <s5h64x0x2pc.wl@alsa2.suse.de>
References: <200505280716.46688.cijoml@volny.cz>
	<20050528154736.3ab2550a@laptop>
	<s5h64x0x2pc.wl@alsa2.suse.de>
X-Mailer: Sylpheed-Claws 1.9.6cvs1 (GTK+ 2.6.4; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2005 15:28:47 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> > Same problem on 2.6.11.11
> > 
> > Current Debian testing, 
> > (Intel Corp. 82801CA/CAM AC'97 Modem Controller)
> 
> Do you mean a regression?  Or just a non-working device?
Non working device.

Semaphore warning is fixed in ALSA CVS (but i still get NO DIALTONE/NO
CARRIER error for this modem).

-- 
 Marcin Bis
