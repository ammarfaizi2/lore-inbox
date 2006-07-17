Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWGQLZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWGQLZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 07:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWGQLZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 07:25:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:12840 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750746AbWGQLZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 07:25:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=ROugipO8wjl++CpYIp092haItweL2owBiw3YRMNyQWRoGi/OC7blDAA08CW3bLT6OAu6siifGDfIJPSV7dVH3zXFgJW6v/SMrZpviWjnpnoMCk0r7EKEC5QTJLiXDIp4kx74nKYFvR9xF4aklOLSOqpz9rZuQGiFktDZvRImm3I=
Date: Mon, 17 Jul 2006 13:25:26 +0200
From: Janos Farkas <chexum+dev@gmail.com>
To: Tony Reix <tony.reix@bull.net>
Cc: =?iso-8859-1?Q?Aim=E9?= Le Rouzic <Aime.Le-Rouzic@bull.net>,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: nfs problems with 2.6.18-rc1
Message-ID: <priv$8d118c145616$a76e56732d@200607.shadow.banki.hu>
Mail-Followup-To: Tony Reix <tony.reix@bull.net>,
	=?iso-8859-1?Q?Aim=E9?= Le Rouzic <Aime.Le-Rouzic@bull.net>,
	linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
References: <priv$8d118c145575$b19af6759a@200607.shadow.banki.hu> <1153127026.2871.12.camel@frecb000687.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1153127026.2871.12.camel@frecb000687.frec.bull.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-07-17 at 11:03:46, Tony Reix wrote:
> Le jeudi 13 juillet 2006 ? 20:22 +0200, Janos Farkas a écrit :
> > I recently updated two (old) hosts to 2.6.18-rc1, and started
> > noticing
> > weird things with the nfs mounted /home s.
> >
> > I frequently face EACCESs where a few minutes ago there wasn't any
> > problem, and after a retry everything does work again.
> Do you have the same problem with the last stable version (2.6.17-rc2)
> we have tested with in depth ?
> See:  http://nfsv4.bullopensource.org/

Even stock 2.6.17 as server works for me with a 2.6.18-rc1 client (v3).

--
Janos
romfs is at http://romfs.sourceforge.net/
