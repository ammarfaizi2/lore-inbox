Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272321AbTHIKlM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 06:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272328AbTHIKlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 06:41:12 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:62478 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S272321AbTHIKk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 06:40:27 -0400
Date: Sat, 9 Aug 2003 12:40:24 +0200
To: gaxt <gaxt@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 cannot mount root fs
Message-ID: <20030809104024.GA12316@gamma.logic.tuwien.ac.at>
References: <3F34D0EA.8040006@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3F34D0EA.8040006@rogers.com>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sam, 09 Aug 2003, gaxt wrote:
> Try changing in your bootloader root=/dev/hdb1 to root=341

tried it already with 
	root=0341
and 
	root=341
on the lilo prompt. No change.

(Beside the kernel telling me:
	VFS: Cannot mount root fs "341" or "hdb1"

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
BENBURB
The sort of man who becomes a returning officer.
			--- Douglas Adams, The Meaning of Liff
