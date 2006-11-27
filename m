Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758071AbWK0MA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758071AbWK0MA3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758076AbWK0MA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:00:29 -0500
Received: from nz-out-0102.google.com ([64.233.162.206]:38678 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1758071AbWK0MA2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:00:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nH1yKSmuG19V9oCqQRGdhDqLV90bdpr+9kxkKStXfhoZIXrIKCZ3MjUJv6TULggCyOoM/Ih0puapAN2KyIda7u9xMpxhgj4YuT/L5fIQmj/+t4MoCqnxu/YMVN23ZrAiezJG0pFULbM4R0U76dyug4q7Ap9H0fWthOYurejws8k=
Message-ID: <9a8748490611270400t1ac8e1eesed9be5a0d308e829@mail.gmail.com>
Date: Mon, 27 Nov 2006 13:00:27 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "=?ISO-8859-1?Q?Hanno_B=F6ck?=" <mail@hboeck.de>
Subject: Re: kernel: Please report the result to linux-kernel to fix this permanently
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200611271242.59642.mail@hboeck.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200611271242.59642.mail@hboeck.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/06, Hanno Böck <mail@hboeck.de> wrote:
> My kernel says
> Oct  7 18:25:00 laverne kernel: Please report the result to linux-kernel to
> fix this permanently
>
> so I do this. Replys CC to me, cause I'm not on this list.
>
...
> Oct  7 18:25:00 laverne kernel: PCI: Bus #04 (-#07) is hidden behind
> transparent bridge #02 (-#04) (try 'pci=assign-busses')
> Oct  7 18:25:00 laverne kernel: Please report the result to linux-kernel to
> fix this permanently
>

And what are the results when you use "pci=assign-busses" as your
kernel asks you to do ?


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
