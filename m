Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965284AbVIOWGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965284AbVIOWGh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 18:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965286AbVIOWGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 18:06:37 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:5555 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965284AbVIOWGg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 18:06:36 -0400
Subject: Re: libata sata_sil broken on 2.6.13.1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: izvekov@lps.ele.puc-rio.br
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <61929.200.141.106.169.1126815191.squirrel@correio.lps.ele.puc-rio.br>
References: <61637.200.141.106.169.1126660632.squirrel@correio.lps.ele.puc-rio.br>
	 <60519.200.141.106.169.1126727337.squirrel@correio.lps.ele.puc-rio.br>
	 <43290893.7070207@pobox.com>
	 <1126790860.19133.75.camel@localhost.localdomain>
	 <61929.200.141.106.169.1126815191.squirrel@correio.lps.ele.puc-rio.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Sep 2005 23:30:05 +0100
Message-Id: <1126823405.7034.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-15 at 17:13 -0300, izvekov@lps.ele.puc-rio.br wrote:
> Just tried that, and it doesnt help. Doesnt change behaviour, at least for
> my problem.

What happens if you call the handler unconditionally ?

