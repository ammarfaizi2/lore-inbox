Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbTDGQhJ (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 12:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263533AbTDGQhJ (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 12:37:09 -0400
Received: from smtp02.web.de ([217.72.192.151]:3345 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263529AbTDGQhI (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 12:37:08 -0400
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: Ed Vance <EdV@macrolink.com>
Subject: Re: modifying line state manually on ttyS
Date: Mon, 7 Apr 2003 18:48:35 +0200
User-Agent: KMail/1.5
References: <11E89240C407D311958800A0C9ACF7D1A33E28@EXCHANGE>
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33E28@EXCHANGE>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304071848.35857.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 April 2003 18:22, Ed Vance wrote:
> No, CTS cannot operate as an output.
>
> The following ioctl calls are implemented in the generic serial driver,
> /usr/src/linux*/drivers/char/serial.c:
> [...]

puh, that's very bad. I have to modify the device.
(Better had informed before building it. :)

Thanks to all, who helped me (although this was not the
very correct list :)

Regards
Michael Buesch.

-- 
My homepage: http://www.8ung.at/tuxsoft
fighting for peace is like fu**ing for virginity

