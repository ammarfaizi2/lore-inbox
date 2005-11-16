Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965215AbVKPDo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215AbVKPDo0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965217AbVKPDo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:44:26 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:52453 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965215AbVKPDo0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:44:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HWJXka5O0+JNWvi16Q50i9nqVKPe2SYEr6ZN4j3kHEv9H3B23Sptk0uyMn923KBKKE9qZxBF0S5i0unSQCPVNPBd+KlgqN1QpBgdUFKcErf4QssqRm2k/L4z9K3ktsqccAYmEf+pDpSL9NTNN+8g+s2AKJOvN+FP0qulG3BAg8s=
Message-ID: <489ecd0c0511151944r1552bae3oed5ee88a49795482@mail.gmail.com>
Date: Wed, 16 Nov 2005 11:44:25 +0800
From: Luke Yang <luke.adi@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: ADI Blackfin patch for kernel 2.6.14
Cc: Greg KH <greg@kroah.com>, bunk@stusta.de, linux-kernel@vger.kernel.org
In-Reply-To: <20051107235035.2bdb00e1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com>
	 <20051101165136.GU8009@stusta.de>
	 <489ecd0c0511012306w434d75fbs90e1969d82a07922@mail.gmail.com>
	 <489ecd0c0511032059n394abbb2s9865c22de9b2c448@mail.gmail.com>
	 <20051104230644.GA20625@kroah.com>
	 <489ecd0c0511062258k4183d206odefd3baa46bb9a04@mail.gmail.com>
	 <20051107165928.GA15586@kroah.com>
	 <20051107235035.2bdb00e1.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
> bix:/home/akpm> grep volatile bfin_r2_4kernel-2.6.14.patch | wc -l
>    2901
>
> Cow.  You know that volatile in-kernel is basically always wrong?
>
  I really don't know that...  Could you refer me to any document or
posts talking about it? thank you!

Regards,
Luke
