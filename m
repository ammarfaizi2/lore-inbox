Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVFTIPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVFTIPO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 04:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVFTIPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 04:15:14 -0400
Received: from isilmar.linta.de ([213.239.214.66]:8354 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261239AbVFTIOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 04:14:44 -0400
Date: Mon, 20 Jun 2005 10:14:43 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm1
Message-ID: <20050620081443.GA31831@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050619233029.45dd66b8.akpm@osdl.org> <42B6746B.4020305@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B6746B.4020305@ens-lyon.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 20, 2005 at 09:46:51AM +0200, Brice Goglin wrote:
> pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
> cs: IO port probe 0x2000-0x2fff: <- stopped here

Could you send me the /proc/ioports from 2.6.12, please? Did some other -mm
kernel work during the past weeks?

Thanks,
	Dominik
