Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbVHQSLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbVHQSLP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 14:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbVHQSLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 14:11:15 -0400
Received: from nproxy.gmail.com ([64.233.182.204]:25188 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751193AbVHQSLO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 14:11:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=L+VYddH3YsiBiYtnfxfxqu+6JDno23Ix9NCnl0/agVRQd5ncVNGiYOAq9PhOrtP6X2h6/tTeVMD9XwbHphsAman0yJWwpDl3hE74Frgql3pjI8iy+tW6bE9wsdNtdGSr2D9+FqZI6SvfaKa/8cEPVIeQBOwSrPLFZ0znXJJ0pio=
Message-ID: <6278d22205081711115b404a9b@mail.gmail.com>
Date: Wed, 17 Aug 2005 19:11:11 +0100
From: Daniel J Blueman <daniel.blueman@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Atheros and rt2x00 driver
Cc: rt2400-general@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2005, Jon Jahren wrote:
> Hello, I'm new to the mailling list, and couldn't find any traces of
> discussing this anywhere. I was wondering why neither the atheros driver
> http://madwifi.sourceforge.net, or the rt2x00 driver
> http://rt2x00.serialmonkey.com /wiki/index.php/Main_Page is included in
> the kernel? 

There is a good chance the rt2x00 driver will get into the kernel tree
in time, since there is no firmware to upload - Ralink Tech
(www.ralink.com.tw) took a design decision to incorporate the firmware
into an EEPROM on-board, allowing their driver to be GPL'd, and the
rt2x00 is a Linux-specific rewrite which is stabilising well.
___
Daniel J Blueman
