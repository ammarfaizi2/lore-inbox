Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWAXVbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWAXVbA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWAXVbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:31:00 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:40932 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750738AbWAXVa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:30:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ZD5Emr++iVCbXbzQPCHmq+bSCodiXbhzP7EJidKA8ju4dTdtDDNHLZBedIPnG+gLLgXrZajFKB9GD5+GE/IosnOcLnOTTG3EBce7fVPE67icBphWznThQCv+FHCksQ8mbxW53IYACWpD97fiKdQTIeNpAx/5WR2aGxhROqE0qZM=
Message-ID: <43D69CA4.4010103@gmail.com>
Date: Wed, 25 Jan 2006 05:31:16 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] intelfb
References: <43D657DE.7080607@t-online.de>
In-Reply-To: <43D657DE.7080607@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Knut Petersen wrote:
> As this driver obviously has problems at least for
> the 915GM: Could someone please point me to a
> reasonable register reference for the graphics part
> of that chip?
> 

That would be Xorg/XFree86 source.  Intel has not released
docs after the 815.

> BTW: Is there really no maintainer?

It's Sylvain Meyer, but he's silent for the past few months.

Tony
