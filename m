Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264562AbUG2New@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbUG2New (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 09:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbUG2New
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 09:34:52 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:13271 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264562AbUG2Nes
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 09:34:48 -0400
Message-ID: <4108FCF5.3040401@namesys.com>
Date: Thu, 29 Jul 2004 17:34:45 +0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040220
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
CC: linux-kernel@vger.kernel.org
Subject: Re: reiser4, kallsyms_lookup, 2.6.7-mm7
References: <200407281506.12876.norberto+linux-kernel@bensa.ath.cx>
In-Reply-To: <200407281506.12876.norberto+linux-kernel@bensa.ath.cx>
X-Enigmail-Version: 0.76.8.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Norberto Bensa wrote:
> Hello everyone,
> 
> well, just out of curiosity (I wanted to play with reiser4) I've patched my 
> 2.6.7-mm7 tree; no rejects. But I get this:
> 
> *** Warning: "kallsyms_lookup" [fs/reiser4/reiser4.ko] undefined!
> 
> How do I get around that warning?
> 

Looks like you turned REISER4_PROF on
Please send .config

> The patch was 
> http://www.namesys.com/auto-snapshots/reiser4-2004.07.27-19.37-linux-2.6.7-mm7.diff.gz
> 
> 
> Thanks in advance,
> Norberto
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


