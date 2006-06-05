Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750927AbWFEV0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWFEV0q (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 17:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWFEV0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 17:26:46 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:32193 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750927AbWFEV0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 17:26:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nXDeB//plA2zYLE+HJMFo5Opxn9IxM7koiGCm3HxBFkoFyikBO1MqQhgGiZlvPWf1NvctjyRtqpZgWt71uayqhBRwQHndpwCAt1NkwsUfbI1Aal82US+zN55Ur/Zvo0bIsr37AMvsF9PIOqIh9Nb7E3oqPDQ74HHSgqx0b58DiY=
Message-ID: <bda6d13a0606051426u43e5a744x99c500df93cc9267@mail.gmail.com>
Date: Mon, 5 Jun 2006 14:26:44 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] i386: print stack size in oops messages
In-Reply-To: <200606042309_MC3-1-C19F-CFFE@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606042309_MC3-1-C19F-CFFE@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> Always print stack size in oops messages.  By having this line
> in every message, ugly newline logic can be removed as well.
>
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Thank you. Since I always use preempt (it saved me from more than
one hard crash when kernel debugging), this is useful too me.
