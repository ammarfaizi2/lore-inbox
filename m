Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWFSBG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWFSBG7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 21:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWFSBG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 21:06:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:38248 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932161AbWFSBG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 21:06:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=lvjeVJq2sP6MdFVkNZtz0+KtChlYjXxfHhJs8BjwsQdy9NNxeDtlAAVJ3JpRVwEz9iPMc3O8U7R3Ze1DZg1nKsWPvQTOSKuLGjn0FHgh8GHu8Sr7jX/KRekSEAH2vj4Ixq7ZTKv4oEBvyqWEt7CqupidRDo/A5j1hm7yUN9JhE0=
Message-ID: <4495F8B1.7020304@gmail.com>
Date: Mon, 19 Jun 2006 03:06:57 +0200
From: Wojciech Moczulski <wmoczulski@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Suspending and resuming a single task
References: <4495F344.8080705@gmail.com> <E1Fs7vj-0003Rm-00@chiark.greenend.org.uk>
In-Reply-To: <E1Fs7vj-0003Rm-00@chiark.greenend.org.uk>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett napisa³(a):
> http://cryopid.berlios.de/ ?

OK, and if I want to parse the path to a file, where process state is saved,
to the kernel and let the kernel module restart the process? Is it possible to
do it this way (without building self-executable binary)?

Regards,
Wojciech

