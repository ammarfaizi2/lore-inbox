Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbUKOIsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbUKOIsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 03:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbUKOIsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 03:48:47 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:23969 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S261550AbUKOIsf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 03:48:35 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] SCSI qla1280: some firmware files cleanups
References: <20041115022640.GX2249@stusta.de>
From: Jes Sorensen <jes@wildopensource.com>
Date: 15 Nov 2004 03:48:34 -0500
In-Reply-To: <20041115022640.GX2249@stusta.de>
Message-ID: <yq07jona465.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Adrian" == Adrian Bunk <bunk@stusta.de> writes:

Adrian> The patch below does the following changes to the qla1280
Adrian> firmware files: - make all this needlessly global code static
Adrian> - remove the unused firmware_version variables


Looks fine to me, though some of those could maybe even be turned into
#define's.

Cheers,
Jes
