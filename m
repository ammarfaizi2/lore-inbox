Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVCGPrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVCGPrv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 10:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVCGPpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 10:45:51 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:61560 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261785AbVCGPpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 10:45:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=nz6Y8NTAILNqG6wzqYWmMxnuxlTTE631lAsmCWk2Y3uZhIm3IXGjyM4xq7G78CPEFtfeqS0BIcr4XCT4CUzKBSoM7lGz2WhmDLQ3zb3KloEz+Th6Y5sDyLlwM/RrwgvjSx2tj3POYDzZvEMP5SE3Xg+CIt1C2fz5X5wTNpcJXOc=
Message-ID: <422C7722.40301@gmail.com>
Date: Mon, 07 Mar 2005 16:45:38 +0100
From: Mateusz Berezecki <mateuszb@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Atheros wi-fi card drivers (?)
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list members,

I've been doing some reverse engineering of madwifi HAL (Hardware 
Abstraction Layer) object file recently.
I ended up with an almost complete source code for one chipset so far 
and I was wondering if it is legal
to publish such source code on the internet? The note on a card says it 
is "protected by us patents <patents number list>".
Does the patent apply to the reverse engineered source code, or just to 
the hardware? Or is it even legal to create such source code?
I would like to ask for some comments regarding this case. And let's say 
the driver works, would it be included into kernel source ?



regards
Mateusz Berezecki
