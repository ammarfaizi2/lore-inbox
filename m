Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWBVHeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWBVHeV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 02:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWBVHeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 02:34:21 -0500
Received: from iona.labri.fr ([147.210.8.143]:21702 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S932180AbWBVHeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 02:34:21 -0500
Date: Wed, 22 Feb 2006 08:34:23 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, linux-kernel@vger.kernel.org
Subject: Re: Fw: [Bugme-new] [Bug 6106] New: EGA problem since 2.6.14
Message-ID: <20060222073423.GA4367@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Andrew Morton <akpm@osdl.org>, adaplas@pol.net,
	linux-kernel@vger.kernel.org
References: <20060219135521.69e9c974.akpm@osdl.org> <20060222014102.GB4956@bouh.residence.ens-lyon.fr> <20060221175710.42579f44.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060221175710.42579f44.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton, le Tue 21 Feb 2006 17:57:10 -0800, a écrit :
> Your patch was against some prehistoric kernel which didn't have the
> vgacon_xres and vgacon_yres initialisations in vgacon_doresize().

Ah, yes, sorry.

> Please confirm that this is correct:

This is indeed.

Regards,
Samuel
