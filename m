Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266256AbUHIId0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266256AbUHIId0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 04:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUHIIdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 04:33:25 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:52414
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S266256AbUHIIdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 04:33:17 -0400
Message-ID: <411736CB.2040607@bio.ifi.lmu.de>
Date: Mon, 09 Aug 2004 10:33:15 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jirka Kosina <jikos@jikos.cz>
Cc: Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org
Subject: Re: FW: Linux kernel file offset pointer races
References: <XFMail.20040805104213.pochini@shiny.it> <Pine.LNX.4.58.0408051228400.2791@twin.jikos.cz>
In-Reply-To: <Pine.LNX.4.58.0408051228400.2791@twin.jikos.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jirka Kosina wrote:

> It hasn't been discussed here, but at 
> http://linux.bkbits.net:8080/linux-2.4/gnupatch@411064f7uz3rKDb73dEb4vCqbjEIdw 
> you can find a patchset fixing (some of) the mentioned problems. This 
> patchset is from 2.4.27-rc5

So this is for 2.4. What about 2.6? Distributors like RedHat have patched
their 2.6.7 kernel accordingly, but I haven't found anything similar in
the kernel tree from kernel.org. Do you know if there is any a fix for
the 2.6 tree, too?

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

