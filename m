Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752075AbWFLW5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbWFLW5k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 18:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbWFLW5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 18:57:40 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:62336 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1752075AbWFLW5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 18:57:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F6txlU/NRS8+AiSOwvciXksflT2wSlFFkJlbd94uqoKXlBdgN6tH8ClMJd+MdPgY/27Jq/xNsNQFYWr2jgmsMZyRilJLHozXAchOOVWfcpP/OGU57aab0XCWXLReJd0L8o6MAGSgQ9F7Hgv/553hZiHq3dF+uanQ34bbfn04WqU=
Message-ID: <9a8748490606121557h2a2d1003n89bc0f2c8080e6c2@mail.gmail.com>
Date: Tue, 13 Jun 2006 00:57:39 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Cc: jeff@garzik.org, matti.aarnio@zmailer.org, rlrevell@joe-job.com,
       folkert@vanheusden.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060612.154801.77056693.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <448D7FB0.9070604@garzik.org>
	 <20060612.130058.78495098.davem@davemloft.net>
	 <9a8748490606121529v4fe3c261jd73ebcb6a06f8386@mail.gmail.com>
	 <20060612.154801.77056693.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/06, David Miller <davem@davemloft.net> wrote:
> From: "Jesper Juhl" <jesper.juhl@gmail.com>
> Date: Tue, 13 Jun 2006 00:29:46 +0200
>
> > features in postfix
>
> We use zmailer, so any suggestions will need to be codified
> in zmailers configuration framework :-)
>
Heh, ok, I've never used zmailer, so I wouldn't know how to do that,
but perhaps someone else could work out how to do those things with
zmailer...
But, the main point was to point out some good things to implement
that can stop a lot of spam without impacting ham in any significant
way. The fact that I personally use postfix to do these things is not
so important, what's important is how the measures work - finding a
way to implement them with any other MTA should be possible :)


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
