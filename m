Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264883AbUFRAba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264883AbUFRAba (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 20:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUFRAba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 20:31:30 -0400
Received: from [213.146.154.40] ([213.146.154.40]:30388 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264883AbUFRAbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 20:31:22 -0400
Date: Fri, 18 Jun 2004 01:31:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: 4Front Technologies <dev@opensound.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040618003118.GA9904@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	4Front Technologies <dev@opensound.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay> <40D23701.1030302@opensound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D23701.1030302@opensound.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Our commercial OSS drivers work perfectly with Linux 2.6.5, 2.6.6, 2.6.7
> and they are failing to install with SuSE's 2.6.5 kernel. The reason is that
> they have gone and changed the kernel headers which mean that nothing works.

Bad luck.  The OSS and ALSA driver in the kernel tree work fine even with
SuSE's tree ;-)

And now stop trolling.  I don't like the gazillions of crappy IBM patches
in their tree either but people that are too clueless to build their own
code shouldn't complain.

