Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWEUGOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWEUGOm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 02:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWEUGOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 02:14:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:14014 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751451AbWEUGOm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 02:14:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=d3+YV0EmgHQTxm8MklatBKmSmrj/MOcLQQbg+pxdkvIYi+CNIlBmfjBJeuJEiQweixPgc4rwa8w/ZAyM2v0EtvpJ2+KOA3v6Q2pBLNrcDt7LaZgFb/nig7Q79omtMTIFghKYXHfuDHO67KJiMP6EcX9IQxWmOcsxfEg8vIayWLA=
Message-ID: <661de9470605202314w59766946n8d77d2bb56904888@mail.gmail.com>
Date: Sun, 21 May 2006 11:44:40 +0530
From: "Balbir Singh" <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
To: "Liu haixiang" <liu.haixiang@gmail.com>
Subject: Re: Oops in kthread
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bf3792800605202306v4b65bcadk51be97e4762b9d0b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bf3792800605200537o2c9c8c47t9310321ae9205296@mail.gmail.com>
	 <661de9470605200625x73929dbeme8fc487265ba66b7@mail.gmail.com>
	 <bf3792800605202306v4b65bcadk51be97e4762b9d0b@mail.gmail.com>
X-Google-Sender-Auth: 9367bdab715145b2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/06, Liu haixiang <liu.haixiang@gmail.com> wrote:
> Hi Balbir,
>
> The FDMA is my coded module. And in my code, I didn't call kthread in
> my code but only call kthread_run once to create one kernel thread
> CallbackManager.
>
> So I don't understand why there is Oops from kthread and called by my
> CallbackManager.
>
> Can anybody explain to me when kthread will be called by the kernel?
> Then I can understand well why Oops happen.
>
> best regards
>
> Liu haixiang
>

Please post the source code, it is easier to help out, otherwise its
like shooting in the dark.

Balbir
Linux Technology Center,
India Software Labs,
Bangalore
