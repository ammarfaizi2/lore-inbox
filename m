Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275139AbRJBPPx>; Tue, 2 Oct 2001 11:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275173AbRJBPPn>; Tue, 2 Oct 2001 11:15:43 -0400
Received: from sushi.toad.net ([162.33.130.105]:47494 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S275139AbRJBPPh>;
	Tue, 2 Oct 2001 11:15:37 -0400
Subject: Re: [PATCH] PnPBIOS 2.4.9-ac1[56] Vaio fix
To: linux-kernel@vger.kernel.org
Date: Tue, 2 Oct 2001 11:15:25 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20011002151526.0AE7510E6@thanatos.toad.net>
From: jdthood@home.dhs.org (Thomas Hood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian: Okay, the patch you submitted under the Subject heading
"[PATCH 2.4.10-ac3] move DMI scan before other subsystem init (especially PnP)"
applied cleanly over 2.4.10-ac3, built and ran correctly on my
ThinkPad 600.

Alan: I'd suggest that this patch (Stelian's dmi scan relocation)
go in next, if it's altogether kosher.  I'll submit a new version
of the pnpbios "additional fixes" patch once that's done.

-- 
Thomas Hood
(Don't reply to the From: address but to jdthood_AT_yahoo.co.uk)
