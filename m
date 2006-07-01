Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWGAOKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWGAOKf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 10:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWGAOKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:10:35 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:13778 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751336AbWGAOKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:10:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=guvGT60sTqdnbREAvnfbgDOx9a0Xs1mmRWG7v16Y2Ia3MFLGVazuBGMQKRsX1EBV/ab/7t+L+20A/pPjPR23M2/cSfwGz2X43sww7jNmvp+e0tpmK2YzyU7oOF2D9JN5CiDHiRu/qUnLYm4WlRgljPw15JjzWjvxG/h4x/tHfMk=
Message-ID: <a44ae5cd0607010710h227ce03fv8a98702a04306f7f@mail.gmail.com>
Date: Sat, 1 Jul 2006 07:10:33 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
Subject: Re: [patch] lockdep, annotate slocks: turn lockdep off for them
Cc: "Arjan van de Ven" <arjan@infradead.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060701140750.GA7342@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060630065041.GB6572@elte.hu> <20060630091850.GA10713@elte.hu>
	 <20060630111734.GA22202@gondor.apana.org.au>
	 <20060630113758.GA18504@elte.hu>
	 <a44ae5cd0606301321y6ce6b7dbo2b405d3d76a670f1@mail.gmail.com>
	 <20060630203804.GA1950@elte.hu>
	 <a44ae5cd0606301545s33496174lcd7136d8bf41897@mail.gmail.com>
	 <1151746867.3195.19.camel@laptopd505.fenrus.org>
	 <a44ae5cd0607010706k74c30a9ey6b7eac49d11e7827@mail.gmail.com>
	 <20060701140750.GA7342@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doh!  User error.  I did a dry-run to make sure it'd apply and forgot
to run again without it.  I'll fix and restest.

Sorry,
       Miles
