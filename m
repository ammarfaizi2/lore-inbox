Return-Path: <linux-kernel-owner+w=401wt.eu-S1751475AbXAHH3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbXAHH3u (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 02:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbXAHH3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 02:29:49 -0500
Received: from web55610.mail.re4.yahoo.com ([206.190.58.234]:20974 "HELO
	web55610.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751475AbXAHH3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 02:29:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Pgn7Pt8qoURz5YuPjxPQ3YPOvBBAwcf+7e7pkduX/YsyfN+zGi9ljvRmXhdCqtjmf2ZouDgfpJ8UYZUiblRQO6bt+tiHN1vlKnVu5EQ8lN9EPU7RTHFTvWp/G3kJxHwUIAUtQEc6X0oCPECb8I1tei65URlrGD2CNR+ttgqoKno=;
X-YMail-OSG: 7fQ6sR8VM1nAWltbvlnDm.tJdr0pFJa3WMia7d3wQobXvz25GXG9OluocHgJ8mbedUaM3bDc2VXfneObNUGpRDvyqe8QRovyWZ9Lwb38594fjxKwrUIMlQ--
Date: Sun, 7 Jan 2007 23:29:47 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1168239852.6202.15.camel@dsl081-166-245.sea1.dsl.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <150027.90187.qm@web55610.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Vadim Lobanov <vlobanov@speakeasy.net> wrote:

> On Sun, 2007-01-07 at 20:09 -0800, Amit Choudhary wrote:
> > I have already explained it earlier. I will try again. You will not need free_2: and free_1:
> with
> > KFREE(). You will only need one free: with KFREE.
> 

I do not want to write this but I think that you are arguing just for the heck of it. Please be
sane.

-Amit

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
