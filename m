Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWGQSSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWGQSSD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 14:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWGQSSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 14:18:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:29578 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751120AbWGQSSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 14:18:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AzyswMTlx3FjrJfeNei4VxJ7mPjqEj5FtrLPrORwYGaQ+oBH28w+8lYFq81Y3+BojLy8oL+Im89qph3LeFDoRxtsOZ/MGINtpLHKeRwLrRNtUogMldigEBzh8cVThfZuZnUfKOjZhiDB+5xulTLp+idzR9kmfcKOXfR9OEIEgCc=
Message-ID: <f96157c40607171117v439cef52m9750e6b985bcb098@mail.gmail.com>
Date: Mon, 17 Jul 2006 20:17:59 +0200
From: "gmu 2k6" <gmu2006@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Re: i686 hang on boot in userspace
In-Reply-To: <f96157c40607171115r4acccb00r3f6d93e3477a3a13@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060714150418.120680@gmx.net>
	 <Pine.LNX.4.64.0607171242440.6761@scrub.home>
	 <20060717133809.150390@gmx.net>
	 <Pine.LNX.4.64.0607171605500.6761@scrub.home>
	 <f96157c40607170759p1ab37abdi88d178c3503fb2e1@mail.gmail.com>
	 <Pine.LNX.4.64.0607171718140.6762@scrub.home>
	 <f96157c40607170858o567abe24r5d9bdd4895a906c9@mail.gmail.com>
	 <f96157c40607170902l47849e42qc4f1c64087a236d8@mail.gmail.com>
	 <Pine.LNX.4.64.0607171902310.6762@scrub.home>
	 <f96157c40607171115r4acccb00r3f6d93e3477a3a13@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

enabling HIGHMEM_64 to get NX bit enabled on a Xeon supporting the bit
does not make the overall system slower with only 4GiB RAM installed,
does it?
