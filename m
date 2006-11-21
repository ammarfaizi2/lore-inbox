Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966944AbWKUJ1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966944AbWKUJ1I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 04:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966948AbWKUJ1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 04:27:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:46534 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S966944AbWKUJ1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 04:27:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ltxSeiwzIMvS2UUZnVpY8tKVFEOUKtTzDZ92IA3kXsEcsLcJmBc1YzC2Vf4iaaHvXdfaU4iiSjeZy+4eIwNeFPrBM63ON1wTZT2ERgQ+T2JbOb007TDZAPs3K5uMI/PJ8ANjunKpesHeRdYKz0Kgy9b6rzPZAHBJzePDzW5/xCc=
Message-ID: <4562C65C.2010802@gmail.com>
Date: Tue, 21 Nov 2006 18:26:52 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Art Haas <ahaas@airmail.net>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: CDROM drive not found when booting using new libata code
References: <20060924221020.GB2080@artsapartment.org>
In-Reply-To: <20060924221020.GB2080@artsapartment.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Art Haas wrote:
> Hi.
> 
> As Linus has just pulled in the large libata changes into his tree, I
> wanted to try out the new code. I'm running Debian on a PIIX
> motherboard, and I've enclosed the 'dmesg' output for the machine
> when booting 2.6.18 which uses the piix.c code in drivers/ide and
> the new 2.6.18+ code which uses ata_piix.c in drivers/ata.

Can you please test 2.6.19-rc5-mm2?

-- 
tejun
