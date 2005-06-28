Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVF1VyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVF1VyG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVF1VxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:53:03 -0400
Received: from smtp2.brturbo.com.br ([200.199.201.158]:5087 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261383AbVF1Vt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:49:56 -0400
Message-ID: <42C1C5FA.7090801@brturbo.com.br>
Date: Tue, 28 Jun 2005 18:49:46 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jean Delvare <khali@linux-fr.org>, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1]  V4L CX88 patch - against 2.6.12-mm2
References: <42C19F6A.6020501@brturbo.com.br>	<20050628232157.214c76fd.khali@linux-fr.org> <20050628143024.121ba151.akpm@osdl.org>
In-Reply-To: <20050628143024.121ba151.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jean Delvare <khali@linux-fr.org> wrote:
> 
>>Your patch adds trailing whitespace in various places:
> 
> 
> Everybody adds trailing whitespace, although usually not so obviously.  I
> remove it again.
> 
> In this case I expect the hunks which you've noticed came about because of
> my cleanup of a previous v4l patch, and whatever system the v4l team are
> using is trying to revert upstream changes which aren't in their tree.
	It wont revert. We are taking care to double check the patches against
undesirable regressions.
> 
> But whatever.  `patch -l' works.
> 
> 

