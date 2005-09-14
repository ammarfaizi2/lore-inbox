Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbVINUf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbVINUf6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbVINUf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:35:57 -0400
Received: from juno.lps.ele.puc-rio.br ([139.82.40.34]:21670 "EHLO
	juno.lps.ele.puc-rio.br") by vger.kernel.org with ESMTP
	id S964929AbVINUf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:35:56 -0400
Message-ID: <60703.200.141.106.169.1126730160.squirrel@correio.lps.ele.puc-rio.br>
In-Reply-To: <60519.200.141.106.169.1126727337.squirrel@correio.lps.ele.puc-rio.br>
References: <61637.200.141.106.169.1126660632.squirrel@correio.lps.ele.puc-rio.br>
    <60519.200.141.106.169.1126727337.squirrel@correio.lps.ele.puc-rio.br>
Date: Wed, 14 Sep 2005 17:36:00 -0300 (BRT)
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

> So that means the irq triggered, but there where no handlers? Also, this
> seems a non-critical fault, why whould the machine lock?

If i use the irqpoll boot option, then it is fine, it boots with no errors
at all, and i can even mount a filesystem on that PATA hd.

