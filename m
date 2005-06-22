Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVFVQvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVFVQvV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVFVQr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:47:58 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:64140 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261665AbVFVQqz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:46:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k3sMY1d7BLJPKP5AgDeATF0RZnSOBbF7qjW7CQ5oZuxoZ5URUr0Cabre34SKvwYfOOUtoQ+46itgcvj0n/QAvzPSWAdST6WnBrQ+Jdornmih7ZFZ1++TrnfcXPYMbChpsG4gmlglpcuXsANVAz1XORQxoqwrPOMoxY5OA1d8zRk=
Message-ID: <f0cc385605062209464d5619a2@mail.gmail.com>
Date: Wed, 22 Jun 2005 18:46:50 +0200
From: "M." <vo.sinh@gmail.com>
Reply-To: "M." <vo.sinh@gmail.com>
To: "Artem B. Bityuckiy" <dedekind@yandex.ru>
Subject: Re: reiser4 plugins
Cc: =?KOI8-R?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, hch@infradead.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <42B98FD5.6050201@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620235458.5b437274.akpm@osdl.org>
	 <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com>
	 <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com>
	 <20050621181802.11a792cc.akpm@osdl.org>
	 <1119452212.15527.33.camel@server.cs.pocnet.net>
	 <42B97F82.6040404@yandex.ru> <20050622155505.GZ11013@nysv.org>
	 <42B98FD5.6050201@yandex.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is it not simpler to ask the reiserfs guys for a detailed explanation
of why and where this plugins' layer differs from using VFS for
plugins and let others comment on that ?
If something cant be done using VFS this layer is needed by reiser4
and has to be merged.

Michele
