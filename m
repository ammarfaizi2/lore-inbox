Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbVCaG20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVCaG20 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 01:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVCaG2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 01:28:25 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:2956 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262506AbVCaG1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 01:27:22 -0500
Date: Thu, 31 Mar 2005 08:27:14 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: Benoit Boissinot <benoit.boissinot@ens-lyon.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.12-rc1-mm3] BUG: atomic counter underflow in smbfs
In-Reply-To: <20050330124456.3da2a2b8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0503310826340.9253@yvahk01.tjqt.qr>
References: <20050330201818.GA18967@ens-lyon.fr> <20050330124456.3da2a2b8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>tried it?  (Last time I looked, cifs didn't work against win98 servers -
>maybe that got fixed).

Well, win98 by itself does not have CIFS support.


Jan Engelhardt
-- 
No TOFU for me, please.
