Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbTLVSzH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 13:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTLVSzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 13:55:06 -0500
Received: from smtp12.eresmas.com ([62.81.235.112]:30392 "EHLO
	smtp12.eresmas.com") by vger.kernel.org with ESMTP id S263891AbTLVSzB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 13:55:01 -0500
Message-ID: <3FE73DBD.8030102@wanadoo.es>
Date: Mon, 22 Dec 2003 19:53:49 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, arnaud@andesi.org
Subject: Re: Oops with 2.4.23
References: <3FE732A7.60402@wanadoo.es> <20031222184439.GP6438@matchmail.com>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:

> How does disabling swap help?

It helps to not test the SWAP memory :-). Really the important
thing is 'P' flag in burnMMX. Otherwise it will test _only_
the cache memory of the processor.


