Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVADSMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVADSMI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 13:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVADSMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 13:12:08 -0500
Received: from mail1.kontent.de ([81.88.34.36]:658 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261749AbVADSMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 13:12:05 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Swsusp hanging the second time
Date: Tue, 4 Jan 2005 19:05:17 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200501041154.19030.oliver@neukum.org> <20050104110839.GF18777@elf.ucw.cz>
In-Reply-To: <20050104110839.GF18777@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200501041905.17744.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 4. Januar 2005 12:08 schrieb Pavel Machek:
> Anyway two suspends in the row seem to work here on 2.6.10+my
> patches. I suspect you have problems with some more obscure driver.

It seems so. A minimalist config will allow the system to
survive. I'll try to find the driver responsible.

	Regards
		Oliver

