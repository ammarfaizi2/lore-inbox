Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWELL2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWELL2g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 07:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWELL2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 07:28:36 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:44332 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751235AbWELL2f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 07:28:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sqR3D3Wv14KEl7dtBuOPRjcMOouP4xu99o82KjKiLgE5O4p27C1Eb06eoHaGtsGQIsgTL68zZKQKmTVa6cUohhUVTe+vdUXZQLLaLaKa9AEcSU/EXEyOiayBkLmXsAIqV6jqGb3hGejbDVR6mbM5vRS9Jg1Q21i0+hxYA8X5ukU=
Message-ID: <9a8748490605120428u2d005bb7nfd2d483664c18800@mail.gmail.com>
Date: Fri, 12 May 2006 13:28:34 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Dhananjay Bhandari" <dhananjay.bhandari@gmail.com>
Subject: Re: SUSE 9 kernel dump an error midway of application run, making application to hang
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <dd5c6820605111803j737b58d2m5c7d8f94494db571@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <dd5c6820605111803j737b58d2m5c7d8f94494db571@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/06, Dhananjay Bhandari <dhananjay.bhandari@gmail.com> wrote:
> When I try to run one of my applications, kernel dumps following error
> in /var/log/messages, and my process hangs.
[snip]
> The kernel version is : 2.6.5-7.97, and platform is X86.
>
Have you tested a recent kernel like 2.6.16.16 or 2.6.17-rc4 (2.6.5 is
pretty old and the bug may have already been fixed)?  Or would it be
possible to get a copy of your application so someone else could test
it on a recent kernel?


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
