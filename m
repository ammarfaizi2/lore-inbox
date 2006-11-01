Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992591AbWKAPMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992591AbWKAPMc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 10:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992592AbWKAPMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 10:12:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:13521 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S2992591AbWKAPMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 10:12:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gdW1DIfFzaaUAFr0UW9ox4iV1XBAi4k9SW8QGQhd7/OnaU7j3Rw7/d7nwZGtYyXvawHKMzpiygF2t8K8UcRlb987zJcXuvXiwHYdqYL+Do4yHsh5BYiQyjUja8q60YULUgsrxoxg8LU1vouIRmZrMO/8AlBbVr+yKRaca3uW03A=
Message-ID: <3dd9a95e0611010712v6112662dy359b6e823c659c9a@mail.gmail.com>
Date: Wed, 1 Nov 2006 23:12:29 +0800
From: "Xiao Niu" <gniuxiao.mailinglist@gmail.com>
To: "albcamus@gmail.com" <albcamus@gmail.com>
Subject: Re: How does the kernel interrupt a user process with code while (1) {}?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <df9815e70611010215i69a8fbe5id381bdaa357388ae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3dd9a95e0611010159h7dc1d7b7o908b599d7b3200f9@mail.gmail.com>
	 <df9815e70611010215i69a8fbe5id381bdaa357388ae@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm reading LKD2, after knowing how processes are managed, I'm eager
to know that question, thanks.

On 11/1/06, albcamus@gmail.com <albcamus@gmail.com> wrote:
> Hi pal,
>
> I think you'd better read some materials on the kernel first. say LKD2.
> Alternatively, you can ask this question elsewhere but not lkml.
>
> Regards,
>
>
>
> 2006/11/1, Xiao Niu <gniuxiao.mailinglist@gmail.com>:
> > As title, thanks ;-)
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>
