Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVGPPN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVGPPN6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 11:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVGPPN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 11:13:58 -0400
Received: from isilmar.linta.de ([213.239.214.66]:54700 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261644AbVGPPM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 11:12:59 -0400
Date: Sat, 16 Jul 2005 17:12:58 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Vincent C Jones <vcjones@networkingunlimited.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.13-rc3][PCMCIA] - iounmap: bad address f1d62000
Message-ID: <20050716151258.GA7819@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Vincent C Jones <vcjones@networkingunlimited.com>,
	linux-kernel@vger.kernel.org
References: <4qGHl-3Hm-11@gated-at.bofh.it> <20050716144024.14C8E1F3DC@X31.networkingunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050716144024.14C8E1F3DC@X31.networkingunlimited.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could you send me the output of /proc/iomem on both a working kernel and on
2.6.13-rc3-APM, please?

Thanks,
	Dominik
