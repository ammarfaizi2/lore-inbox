Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWGRV44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWGRV44 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 17:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWGRV44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 17:56:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:16472 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932195AbWGRV4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 17:56:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fMH8kS83jwwmyAEXO365UAN/nsrqcFhX7UGk1CNlGSk4vpS3opVj+zeBKnb80ooAwonBnprGJvSj6P5/e5/XRB1iKWDZKheY/fYuh3Vn21aEHT+Y0ZPDohIlQtECrq5NsrezccJcX8+XrFxdx/SALJ8ZeKafWEJhrkdkpD7aQec=
Message-ID: <9a8748490607181456v508f40a8qa06a1259d0b8e17@mail.gmail.com>
Date: Tue, 18 Jul 2006 23:56:54 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: 2.6.18-rc2 allyesconfig doesn't build - undefined references to hdlc_set_carrier
Cc: linux-kernel@vger.kernel.org, paulkf@microgate.com
In-Reply-To: <20060718.145555.32724710.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607182352.40222.jesper.juhl@gmail.com>
	 <20060718.145555.32724710.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/06, David Miller <davem@davemloft.net> wrote:
> From: Jesper Juhl <jesper.juhl@gmail.com>
> Date: Tue, 18 Jul 2006 23:52:39 +0200
>
> > Just tried an allyesconfig build of 2.6.18-rc2 and it fails with this error :
>
> There is a fix for this already sitting in the net-2.6 GIT
> tree, which will be pushed to Linus when he returns.
>
Ok, thanks.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
