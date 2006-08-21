Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWHUILP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWHUILP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 04:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWHUILP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 04:11:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:18795 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030299AbWHUILO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 04:11:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=gANnQ7/MGSMnSAcOj8TShIGZXhfoMTBZXMGS5xAeI1fChXSLKnfQEQfTzGajbiIL0Zl+zPkWcIVK0J/xtsDSvP63JIXET6W30r6TP671aWS5aDO/3vv0lYXU7vQuVbLgNqE0pJN5muVsf7Kpr0LR71mmH8gFI3+UADcFVS7jqbo=
Message-ID: <44E96A9C.6090303@gmail.com>
Date: Mon, 21 Aug 2006 10:11:08 +0200
From: Maciej Rutecki <maciej.rutecki@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: Re: 2.6.18-rc4-mm2
References: <20060819220008.843d2f64.akpm@osdl.org>	 <44E86282.9020406@gmail.com> <6bffcb0e0608200634r5c836053r8fa5cea7b9fdb4cb@mail.gmail.com>
In-Reply-To: <6bffcb0e0608200634r5c836053r8fa5cea7b9fdb4cb@mail.gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski napisa³(a):

> please revert fs-cache-make-kafs-use-fs-cache-12.patch
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm2/broken-out/fs-cache-make-kafs-use-fs-cache-12.patch

Thanks it works.

-- 
Maciej Rutecki <maciej.rutecki@gmail.com>
http://www.unixy.pl
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
