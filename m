Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261300AbTCTDBZ>; Wed, 19 Mar 2003 22:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbTCTDBY>; Wed, 19 Mar 2003 22:01:24 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:60290 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S261300AbTCTDBY>;
	Wed, 19 Mar 2003 22:01:24 -0500
Date: Wed, 19 Mar 2003 22:15:41 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: John Kim <john@larvalstage.com>
Cc: "Ruslan U. Zakirov" <cubic@wildrose.miee.ru>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.65] pnp api changes to sound/isa/sb/es968.c
Message-ID: <20030319221541.GC13998@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	John Kim <john@larvalstage.com>,
	"Ruslan U. Zakirov" <cubic@wildrose.miee.ru>, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.53.0303190650530.28260@quinn.larvalstage.com> <861563974656.20030319180923@wr.miee.ru> <Pine.LNX.4.53.0303191059100.28260@quinn.larvalstage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0303191059100.28260@quinn.larvalstage.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for submitting this patch.  I'll look over it and add it to my tree.

Please note that the following ALSA drivers have now been converted.

ALS100
AZT2320
SB16 and AWE PnP
es968

Patches for these drivers and others will be available soon.

Thanks,
Adam
