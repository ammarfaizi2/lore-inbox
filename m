Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161030AbWJRO2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbWJRO2h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161036AbWJRO2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:28:37 -0400
Received: from qb-out-0506.google.com ([72.14.204.227]:31171 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161030AbWJRO2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:28:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=G7ESg0KFC8bhS2Z9tkKiJ5IwGD0juUwA9UBdx3cZW7tlidxbc9s35dNpeKFWfBhcVDAXDlPwsVPWVyjP/QD1D9fT9QoExpGOOWURTwo7ZSywOZX7SCaujEsfBaQUkXpw4Dm0Pocie0cDYgH5hj64T9qB2UBNOIzFE/SZCWSLdXE=
From: Christopoulos Panagiwtis <pxrist@gmail.com>
Organization: xxx
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Most stable kernel for mpich2 cluster?
Date: Wed, 18 Oct 2006 17:28:25 +0300
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200610171430.01032.pxrist@gmail.com> <1161092423.24237.171.camel@localhost.localdomain>
In-Reply-To: <1161092423.24237.171.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610181728.26372.pxrist@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 October 2006 16:40, Alan Cox wrote:
> The older kernels shipped by vendors are not "vanilla source" because
> that would lack all the bug and security fixing done.
>
> Alan

You are right, I understand this now, I knew the meaning of "vanilla source" 
but didn't come in my mind that 	debian 2.6.8 for example is not vanilla 
source but a tree based on vanilla including patches from debian developers, 
sorry. I will follow Jacob's advice and I will ask in beowulf mailing list 
about what kernel I should use. I am two days in linux kernel lists and I can 
see that you work really hard here, so I won't annoy you again with such 
questions.

keep up the good work, all of you,

Panos 

(Alan, we have a poster of you in my university:p)
