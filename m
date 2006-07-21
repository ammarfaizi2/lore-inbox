Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbWGUCmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbWGUCmk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 22:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbWGUCmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 22:42:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:61291 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030446AbWGUCmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 22:42:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gup4G33nXUruxPSPVIpcZoUW9o2qa9ZvwtUzzjR/X+3QVr1k/CgXf3woTAHZxmrRwyQzTnek2a4AkJCxH/jLq9N/+twQiB/GbIj++/C0IHUujyaziesqSYTPbWk1tlUwekuRODsH9KV5M0Cm7RqQFa3UZwKFld73I2qC+uV3/Xo=
Message-ID: <a63d67fe0607201942s4702cf42u38629d5729df5c2e@mail.gmail.com>
Date: Thu, 20 Jul 2006 19:42:38 -0700
From: "Dan Carpenter" <error27@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: shut down from CPU 0 [regression]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m1hd1bkdv7.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a63d67fe0607171952o539a6a29te75ef332bcdbba22@mail.gmail.com>
	 <m1hd1bkdv7.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Dan Carpenter" <error27@gmail.com> writes:
>
> I don't understand the complaint we should be forcing the action to
> happen on the boot cpu from another place in the code.
>
> Eric
>

Crap.  I'm an idiot.  I didn't realize you moved the code, i thought it was
just deleted.  The comment from that fuction could be deleted too if
you want.

Sorry about that.

regards,
dan carpenter
