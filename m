Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964769AbWADRSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964769AbWADRSr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWADRSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:18:47 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:19132 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964769AbWADRSq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:18:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KxDA4kJqAGTNxQt2iiNNZ6GabUJbYyWt/emVSAVeggencca0R3QKh24l4Sb3BvafFiunAVh0blW51FP/x4FclOCm0dmgu21drRrq1H3kdu8o25Ztv1Uo8SAMkUM1qAcsItmx9qYQuwbxw4q3z0LNFB7z+nqD6Qh5y8yjZJ/MR/E=
Message-ID: <9a8748490601040918p24674d86j132315e9c8875483@mail.gmail.com>
Date: Wed, 4 Jan 2006 18:18:44 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Nick Warne <nick@linicks.net>
Subject: Re: 2.6.14.5 to 2.6.15 patch
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200601041710.37648.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601041710.37648.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Nick Warne <nick@linicks.net> wrote:
> Hi all,
>
> A stupid question - buggered if I can find a kernel patch from 2.6.14.5 to
> 2.6.15?
>
> Is there one?
>
No.

What you do is you first revert the 2.6.14.5 patch so you are left
with a 2.6.14 kernel, then you apply the 2.6.15 patch.
For more info, please read Documentation/applying-patches.txt
(http://sosdg.org/~coywolf/lxr/source/Documentation/applying-patches.txt)
--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
