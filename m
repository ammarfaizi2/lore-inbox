Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751117AbWFENnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWFENnm (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 09:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWFENnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 09:43:42 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:63552 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751119AbWFENnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 09:43:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cerAPVUjpwN2ougJIDoSmTLSKz1NsbhsFYdm+h59VP00dtXzQfQw6PI9xQYEPR9OeGQ+F2cKuGcLMLGs7kqpBwuQcIClR6lYDDH39jKiMOvP9i7qwkFZb1uFSInnzXGsoZS9PIKQSuNBfIDWIf8JoA/9QXKBrBgNLtuR5fO0aV8=
Message-ID: <9a8748490606050643p50409b5atd93ff3e979b984e6@mail.gmail.com>
Date: Mon, 5 Jun 2006 15:43:40 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.6.17-rc5-mm2+hotfixes when loading snd modules
Cc: "Andrew Morton" <akpm@osdl.org>, "Takashi Iwai" <tiwai@suse.de>
In-Reply-To: <200606051422.32276.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606051422.32276.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> I get the following Oops at boot when loading my sound modules :
>
> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000044

It seems 2.6.17-rc5-mm3 has resolved this issue.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
