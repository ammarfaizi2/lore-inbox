Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVKZWQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVKZWQn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 17:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVKZWQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 17:16:43 -0500
Received: from [82.94.235.172] ([82.94.235.172]:19848 "EHLO
	mail.hipersonik.com") by vger.kernel.org with ESMTP
	id S1750755AbVKZWQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 17:16:42 -0500
From: Norbert van Nobelen <norbert-kernel@hipersonik.com>
To: David Brown <dmlb2000@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.14.tar.bz2 permissions
Date: Sat, 26 Nov 2005 23:19:14 +0100
User-Agent: KMail/1.8.2
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com> <9c21eeae0511261358v723419f2g853bddc839038996@mail.gmail.com>
In-Reply-To: <9c21eeae0511261358v723419f2g853bddc839038996@mail.gmail.com>
Organization: Hipersonik.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511262319.15042.norbert-kernel@hipersonik.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The rights on the files should be sufficient for the compiler to go through 
the tree and compile the kernel for you. If it bothers you, you can just run 
chmod -R to correct it.
I guess that it will not be corrected.

On Saturday 26 November 2005 22:58, you wrote:
> I wasn't sure where to send this but here goes.
>
>  Seems that many of the source files in the linux-2.6.14.tar.bz2 have
> global read/write permissions.
>  Are the permissions supposed to be this way now?
>  If not, could this be fixed soon?
>  if so, could you point me to a url that explains why.
>
>  - David Brown
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
________
www.hipersonik.com : Open source experts
