Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbTL2Iga (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 03:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbTL2Iga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 03:36:30 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:34178 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262888AbTL2Ig3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 03:36:29 -0500
Date: Mon, 29 Dec 2003 09:36:10 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: akmiller@nzol.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide: "lost interrupt" with 2.6.0
Message-ID: <20031229093610.A8892@electric-eye.fr.zoreil.com>
References: <1072657930.3fef760a50062@webmail.nzol.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1072657930.3fef760a50062@webmail.nzol.net>; from akmiller@nzol.net on Mon, Dec 29, 2003 at 01:32:10PM +1300
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akmiller@nzol.net <akmiller@nzol.net> :
[accusys acs7500 lost interrupt]
> Has anyone else seen this sort of problem? (Sorry if this is a known issue, I

Probably but with a slightly different model:
        Model Number:       Accusys ACS7500 A2X1
        Serial Number:      A75X000881
I saw some interesting things where an ACS7500 was smart enough to pass the
announced lba48 capability of the disk whereas it could not really handle it.
Do you notice the same issue with a non-lba48 capable disk ?

--
Ueimor
