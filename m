Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVJXJ2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVJXJ2Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 05:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVJXJ2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 05:28:16 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:41583 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750812AbVJXJ2P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 05:28:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AGAPcSsSbWHoMxhCtJv187UQhqIo+Nm5HL8BD7THYXHNe4n4IcwfL2KO0/PthDa9cFM0kkkbk/iEIWGGB3zL+WFD0f/t/PrPCGiEldQNcCbbAj0/o54qVKcORfd3KL4QHBJuSslB7rdWBUKWXcYmCrdOnqU+O8g48pIqOvDe8gk=
Message-ID: <aec7e5c30510240228v592757cdg57b4c149eae537fd@mail.gmail.com>
Date: Mon, 24 Oct 2005 18:28:14 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-rc5-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051024014838.0dd491bb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051024014838.0dd491bb.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Could you please consider including the following in your -mm tree?

srat fix on i386, simple fix - no interest.
http://lkml.org/lkml/2005/9/16/14

cpusets on non-smp hardware, acked by Paul Jackson.
http://lkml.org/lkml/2005/10/3/48

Both applies on top of 2.6.14-rc5-mm1.

Many thanks,

/ magnus
