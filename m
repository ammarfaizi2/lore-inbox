Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265725AbUEZRSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265725AbUEZRSi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 13:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265723AbUEZRSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 13:18:38 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:39618 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265725AbUEZRSb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 13:18:31 -0400
Date: Wed, 26 May 2004 19:16:19 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nforce2 keeps crashing with 2.4.27pre3
Message-ID: <20040526191619.B6244@electric-eye.fr.zoreil.com>
References: <200405261756.35333.cleanerx@au.hadiko.de> <40B4C4D4.8070100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40B4C4D4.8070100@pobox.com>; from jgarzik@pobox.com on Wed, May 26, 2004 at 12:24:52PM -0400
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> :
[...]
> Driver bugs...  r8169 needs updating.

Do you have a specific option in mind:
- simple 2.6.6 backport (no napi nor ethtool support);
- netdev backport (2.6.6 + napi)
- new wave (2.6.6 + napi + ethtool/link/TBI rework)
- other ?

--
Ueimor
