Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbVKPIkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbVKPIkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbVKPIkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:40:10 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:17910 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030230AbVKPIkJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:40:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E7ZDKjvzzUgafeXCe/rI/H3p3fbdmuoONp7RxErD0Nbli4BL3q/pDoud/DUljsIs0Pp/jCJrxQRmfKKqHRoqJrwazjxRops/oRydp37AV9TfaGFsoi/4ZxsUVYy8dVcbfHZTK7QkTfaG28V6V8g+LkIQAg5OrsBLuBuL4XS11mU=
Message-ID: <cbec11ac0511160040l86523bavc04a2a950348b79d@mail.gmail.com>
Date: Wed, 16 Nov 2005 21:40:08 +1300
From: Ian McDonald <imcdnzl@gmail.com>
To: Hua Feijun <hua.feijun@gmail.com>
Subject: Re: help
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3fe1d240511160026h4a262a05u@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3fe1d240511160026h4a262a05u@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/05, Hua Feijun <hua.feijun@gmail.com> wrote:
> Hi everybody!
> Could anybody tell me the differentia between linux/em64t and linux/ia64?
> Should i notice anything during migrating a project form linux/ia64 to
> linux/em64t?
> Thanks!!!

They are two quite different processor architectures. Have a look
using Google at AMD Opteron/Intel Pentium 4 64 bit vs Intel Itanium
(IA64).

At the minimum you will need to recompile anything you do as they are
incompatiable

--
Ian McDonald
http://wand.net.nz/~iam4
WAND Network Research Group
University of Waikato
New Zealand
