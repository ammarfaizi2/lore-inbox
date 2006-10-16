Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422905AbWJPWiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422905AbWJPWiu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422908AbWJPWiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:38:50 -0400
Received: from av1.karneval.cz ([81.27.192.123]:62795 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1422905AbWJPWis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:38:48 -0400
Message-ID: <453409F3.4010003@gmail.com>
Date: Tue, 17 Oct 2006 00:38:43 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl,
       Amit Gud <gud@eth.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 1/1] Char: correct pci_get_device changes
References: <1966866271061818079@wsc.cz> <20061016153625.eda40799.akpm@osdl.org>
In-Reply-To: <20061016153625.eda40799.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sun, 15 Oct 2006 01:36:45 +0200 (CEST)
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> correct pci_get_device changes
> 
> I suspect this patch was against -mm, but fixes problems in mainline, to
> which it doesn't apply.
> 
> Could I have a new one against mainline please?  With a changelog updated
> to reflect Alan's comments?

Sure, thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
