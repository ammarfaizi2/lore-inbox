Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTIXJI4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 05:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbTIXJI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 05:08:56 -0400
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:19145 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S261326AbTIXJIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 05:08:55 -0400
From: Ingo Oeser <ioe-lists@rameria.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [OOPS] 2.4.22, USB visor module crashing on HotSync.
Date: Wed, 24 Sep 2003 11:05:32 +0200
User-Agent: KMail/1.5.3
References: <20030905152436.GB16363@kroah.com>
In-Reply-To: <20030905152436.GB16363@kroah.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309241105.32083.ioe-lists@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
hi lkml,

On Friday 05 September 2003 17:24, you wrote:
> Nice, someone else reported this yesterday for the ftdi_sio driver.
>
> Can you test the patch below and let me know if this fixes it?

It fixes it. Now it doesn't oops anymore.

Regards

Ingo Oeser


