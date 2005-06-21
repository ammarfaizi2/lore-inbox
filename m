Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVFUVFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVFUVFm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbVFUVEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 17:04:42 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:40440 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262340AbVFUUr4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:47:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fFCi1yuDJN79UQVgNpn15Y1hmzRvbK8JqcWBiOnRufcM+HmE0vjRspzgKLDR3WUUu0WEFhO8QX0086z1TW2ylgA+2YfnQUbtyUUmxsY3mVddFvEeyRZUXo1Fpt73yZSmfaPfJ6NglfdPRNBXRzpYw54Wr9aRSX2Ls0rTE0PX0MU=
Message-ID: <9a87484905062113473b4d02b9@mail.gmail.com>
Date: Tue, 21 Jun 2005 22:47:51 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] cleanup patches for strings
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Jesper Juhl <juhl-lkml@dif.dk>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Domen Puncer <domen@coderock.org>, Andrey Panin <pazke@donpac.ru>,
       cutaway@bellsouth.net, Denis Vlasenko <vda@ilport.com.ua>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
In-Reply-To: <20050621093119.GG27887@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost>
	 <200506211259.22650.adobriyan@gmail.com>
	 <20050621093119.GG27887@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all the input guys. I guess submitting all these in a big
bunch is not such a good thing after all.. Probably a careful
evaluation of each one and a slow trickle of patches over time will be
better.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
