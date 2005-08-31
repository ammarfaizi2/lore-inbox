Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbVHaSXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbVHaSXN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 14:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbVHaSXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 14:23:13 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:1096 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964914AbVHaSXN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 14:23:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Oop7PnQv+CkoGIn9IwsvzIOvVTUaBJhfyoG9g7AjKmkZ5KcouxlS/62nNwGd3/SqopqSLbD82viuEN5twCoa6ViGL2Q+ofCP490tvov1fEEcDYDhNYxhfkJnHx3dosyb/81B13k5hwBt77QVusJ/zU3dTWWcGt+dXZxkWYOPkG4=
Message-ID: <9e4733910508311123618b8851@mail.gmail.com>
Date: Wed, 31 Aug 2005 14:23:04 -0400
From: Jon Smirl <jonsmirl@gmail.com>
To: jg@freedesktop.org,
       Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>
Subject: Re: State of Linux graphics
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1125510491.12626.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e47339105083009037c24f6de@mail.gmail.com>
	 <1125422813.20488.43.camel@localhost>
	 <20050831063355.GE27940@tuolumne.arden.org>
	 <1125510491.12626.8.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/05, Jim Gettys <jg@freedesktop.org> wrote:
> Certainly replicating OpenGL 2.0's programmability through Render makes
> no sense at all to me (or most others, I believe/hope).  If you want to
> use full use of the GPU, I'm happy to say you should be using OpenGL.
>                                 - Jim

This is the core point of the article. Graphics hardware is rapidly
expanding on the high end in ways that are not addressed in the
existing X APIs.

The question is, what do we want to do about it? I've made my
proposal, I'd like to hear other people's constructive views on the
subject.

-- 
Jon Smirl
jonsmirl@gmail.com
