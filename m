Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUFUDyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUFUDyf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 23:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266001AbUFUDyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 23:54:35 -0400
Received: from holomorphy.com ([207.189.100.168]:10134 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264256AbUFUDyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 23:54:24 -0400
Date: Sun, 20 Jun 2004 20:54:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.6.7-uc0 (MMU-less fixups)
Message-ID: <20040621035417.GY1863@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org
References: <40D65A88.8080601@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D65A88.8080601@snapgear.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 01:48:24PM +1000, Greg Ungerer wrote:
> An update of the uClinux (MMU-less) fixups against 2.6.7.
> A few more things merged in 2.6.7, so only a handful of patches
> for general uClinux and m68knommu.
> http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.7-uc0.patch.gz
> Change log:
> . merge linux-2.6.7                          me
> . more Feith hardware support                Werner Feith
> . stop 5282 pit timer from going backwards   me/Felix Daners
> . fix PHY race confition in FEC driver       Philippe De Muyter
> . fix OOM killer for non-MMU configs         Giovanni Casoli

Could you send the OOM killer fix out to mainline?

Thanks.


-- wli
