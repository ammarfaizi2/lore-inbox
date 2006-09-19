Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWISWDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWISWDY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 18:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWISWDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 18:03:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:63651 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751160AbWISWDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 18:03:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Wlon3tMuk3sk94aG72oS5effAgI2sEQUZv0IvF/y1uhAS24a8RYvyf/Dki15+QjKvdQRK1ESX+WLORcbTIVAugH+3cBlEKXRBJVK0X1otIF+ZJ3MDgyJLVWQN9I76wxA2zlExLjtSGd914tZb/M5vGoceDZmc/Yae1pM5DR+A3o=
Message-ID: <45106927.4020105@gmail.com>
Date: Wed, 20 Sep 2006 00:03:19 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Dalibor Straka <dast@panelnet.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Possible bug in ACPI
References: <20060919214724.GB2073@panelnet.cz>
In-Reply-To: <20060919214724.GB2073@panelnet.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dalibor Straka wrote:
> BTW: Bios says i have 1024MB, but kernel sees 899MB :-?. The system is

And is highmem enabled?

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
