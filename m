Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269243AbUHZRTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269243AbUHZRTc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269163AbUHZRSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 13:18:52 -0400
Received: from host50.200-117-131.telecom.net.ar ([200.117.131.50]:43202 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S269269AbUHZRIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:08:55 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: Reiser 4
Date: Thu, 26 Aug 2004 14:08:46 -0300
User-Agent: KMail/1.7
Cc: "Rodrigo FGV" <rodrigof@bifgv.com.br>
References: <006601c48bad$00c4b130$0700a8c0@ti10>
In-Reply-To: <006601c48bad$00c4b130$0700a8c0@ti10>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408261408.46998.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rodrigo FGV wrote:
> how i convert reiser3.6 to reiser4. 

Backup. Reformat. Restore.

> this update is safe??? 

Dunno. Many people is using it, so I guess it is.

> the reiser4 have any critical bug?? 

Doesn't like 4KSTACKS :(

> anyone recommend this update??? 

Hans does ;)
And I would if it compiled with 4KSTACKS.

Best Regards,
Norberto
