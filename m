Return-Path: <linux-kernel-owner+w=401wt.eu-S964948AbWL2G5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWL2G5o (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 01:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbWL2G5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 01:57:43 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:37686 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964948AbWL2G5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 01:57:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h2Y2rIn/hN3ZgpM+suYrBIRC3Uytaa6TA6Sva/KLSNtV1AQ787nc53wsLTX9hHjI/cPQiUomzBrw2GhrPm/+tvmAT6tvuZ2qBkmXAPQCOcWsGFJMKWapY3XGU6pHRK28QfvRSXiybzbyt85gW5deI3StcL19PGMBh7lgFrgZqfI=
Message-ID: <80ec54e90612282257m4175347x226cd1b045059336@mail.gmail.com>
Date: Fri, 29 Dec 2006 07:57:41 +0100
From: "=?ISO-8859-1?Q?Daniel_Marjam=E4ki?=" <daniel.marjamaki@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: Want comments regarding patch
Cc: "Arjan van de Ven" <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0612290043050.23545@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <80ec54e90612281041q3b2c2bcemb0308c1e89a29ac@mail.gmail.com>
	 <1167331995.3281.4374.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0612290043050.23545@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Thank you for your comments. It seems to me the issue was the readability.

It was my goal to improve the readability. I failed.

I personally prefer to use standard functions instead of writing code.
In my opinion using standard functions means less code that is easier to read.

Best regards,
Daniel
