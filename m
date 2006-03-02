Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751974AbWCBI6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbWCBI6T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 03:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbWCBI6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 03:58:19 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:53387 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751974AbWCBI6T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 03:58:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UzIFwBjzd6/Af72XWaPCTZ4FTCmzElqOi1EnlJ1izBiDBTL25LtbkWnP3iIsOAtMN3klLiOiiFkuH2NKn70WTFViAqdKEOqS5QMedDHFLYsaC0MYMzlFOvPCeLOgoB8puTcj38VXBw0HyL1cAqcIoV8ZSV7CdVx8eNREsOuT8SM=
Message-ID: <d6fe45ba0603020058h55e68bcy39ae4b9d234ed6cc@mail.gmail.com>
Date: Thu, 2 Mar 2006 09:58:17 +0100
From: "matteo brancaleoni" <mbrancaleoni@gmail.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: Bio & Biovec-1 increasing cache size, never freed during disk IO
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d6fe45ba0603020019td998ba5we1cb2b689d459e1a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d6fe45ba0602251245h32b9ac5dw65246ed6e1bba607@mail.gmail.com>
	 <d6fe45ba0602271238q10fea0f8tfc29f0d51c4df1c8@mail.gmail.com>
	 <17411.33114.403066.812228@cse.unsw.edu.au>
	 <d6fe45ba0602280705l6f38f1b8j3126d0be638be8fa@mail.gmail.com>
	 <17412.56916.247822.749271@cse.unsw.edu.au>
	 <d6fe45ba0603010246j15132126x3cb233092319c772@mail.gmail.com>
	 <17414.36065.898271.383401@cse.unsw.edu.au>
	 <d6fe45ba0603020019td998ba5we1cb2b689d459e1a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

I can confirm that the latest patch works nice on 2.6.16-rc5 !

Thanks a lot for the support!

Greetings, Matteo.

P.S. if you need some more details/tests/info I'm here to help.
