Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWIYSFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWIYSFp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWIYSFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:05:45 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:7834 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751236AbWIYSFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:05:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rIb3qH9DCcyCor2UFJaBmufCUz/Jpr4YvsK62NPdZjmaDDXLSGrhbPETCmxPUeRI0PGFratYzhKt8w0mf/YseqozUDOglDJfrDJJW/4jm0vLARGobnZH9F6ltzlTpsugVdKchlzsu+iI2m55PrlI52qKv4G44O/O/rAD8/F6eQA=
Message-ID: <8bd0f97a0609251105g7da7f41cm27a5a93bd704d7cb@mail.gmail.com>
Date: Mon, 25 Sep 2006 14:05:43 -0400
From: "Mike Frysinger" <vapier.adi@gmail.com>
To: "Randy Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20060925095223.515d9f2b.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
	 <20060925095223.515d9f2b.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/06, Randy Dunlap <rdunlap@xenotime.net> wrote:
> Here are the rest of my comments (on .c files now).

i went through a bunch of our .c files this weekend with a hammer and
had fixed a bunch of points you raised here ... i'll try and grab a
bunch of the rest as well

cheers
-mike
