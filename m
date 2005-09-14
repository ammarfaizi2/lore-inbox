Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbVINBWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbVINBWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 21:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbVINBWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 21:22:40 -0400
Received: from juno.lps.ele.puc-rio.br ([139.82.40.34]:61604 "EHLO
	juno.lps.ele.puc-rio.br") by vger.kernel.org with ESMTP
	id S932550AbVINBWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 21:22:39 -0400
Message-ID: <61662.200.141.106.169.1126660965.squirrel@correio.lps.ele.puc-rio.br>
In-Reply-To: <61637.200.141.106.169.1126660632.squirrel@correio.lps.ele.puc-rio.br>
References: <61637.200.141.106.169.1126660632.squirrel@correio.lps.ele.puc-rio.br>
Date: Tue, 13 Sep 2005 22:22:45 -0300 (BRT)
Subject: Re: libata sata_sil broken on 2.6.13.1
From: izvekov@lps.ele.puc-rio.br
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-6.FC2
X-Mailer: SquirrelMail/1.4.3a-6.FC2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> please disregard:
> ata2 is slow to respond, please be patient
> ata2 failed to respond (30 secs)
> because that is probably a design flaw of the bridge. the SIL bios takes
> very long to pass thru it if there is nothing connected to the PATA end of
> the bridge aswell.

Sorry, the reason for this is that i missed the attachment of the dmesg
output
I will provide it if someone asks
