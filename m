Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbVIFNaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVIFNaF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 09:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVIFNaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 09:30:05 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:35043 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932466AbVIFNaB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 09:30:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=hU4/6bDoco2sGx9mFnTS/oYDonCBFgotqgZLM4AMgSYAxlinroogQWjSUiblqzUTUIcz4qYVB3EUgPiJKcJIFEbCdRegswHN87c6L9jd+PZahPc27T6/ZpzaQoKMrL28vOA7oRAxfSo2ozNytO2tpoem6LvKpbEhT5kjzDjbDi4=
Date: Tue, 6 Sep 2005 15:29:42 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: ak@suse.de, vda@ilport.com.ua, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
Message-Id: <20050906152942.dc311fa8.diegocg@gmail.com>
In-Reply-To: <1125991977.5138.6.camel@npiggin-nld.site>
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com>
	<p73aciqrev0.fsf@verdi.suse.de>
	<200509060939.28055.vda@ilport.com.ua>
	<200509060913.59822.ak@suse.de>
	<1125991977.5138.6.camel@npiggin-nld.site>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.2; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 06 Sep 2005 17:32:57 +1000,
Nick Piggin <nickpiggin@yahoo.com.au> escribió:


> Are there still good reasons to have such a thing?

Bigger block sizes was one of their features.
