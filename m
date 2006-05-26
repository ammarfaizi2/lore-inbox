Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWEZKsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWEZKsX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 06:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWEZKsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 06:48:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:50036 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751390AbWEZKsX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 06:48:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RBV6pQLpHODBsZd6OfKlkfI5c+sc6hgnq7WQmDDRnZKHLxLoH4u4f6TSajvvubO6J1dnRWXXUBMeZ8+WnyNk4+FLcQ63Qdc8/dgIjaiwp6WXgF2R89EEIEr/bi5fEfLlJsbtB094poHklmo8O0h4yaInbGO8cP5I0h/LYK/9d/s=
Message-ID: <36e6b2150605260347o659c8b9dw136aeaf0fcbac517@mail.gmail.com>
Date: Fri, 26 May 2006 14:47:50 +0400
From: "Paul Drynoff" <pauldrynoff@gmail.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: [PATCH] kmalloc man page before 2.6.17
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490605260248i68a1eb84hc241068ae1f012bb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <36e6b2150605260007h1601aa04v31c6c698c6e4d1b9@mail.gmail.com>
	 <84144f020605260017i4682c409vc4a004d016c31270@mail.gmail.com>
	 <36e6b2150605260058h5c1fbc0cla686a37d5bf3e34e@mail.gmail.com>
	 <Pine.LNX.4.58.0605261059360.30386@sbz-30.cs.Helsinki.FI>
	 <36e6b2150605260120s2fb692fegf4fef1eecf7c4674@mail.gmail.com>
	 <9a8748490605260248i68a1eb84hc241068ae1f012bb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> Btw: how about vmalloc() do we need to document that one as well
> (didn't check) ?
>

There are vmalloc(9) and vfree(9) on my machine, so I suppose all ok
with this functions.
