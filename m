Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261622AbSJUU1J>; Mon, 21 Oct 2002 16:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261627AbSJUU1J>; Mon, 21 Oct 2002 16:27:09 -0400
Received: from videira.terra.com.br ([200.176.3.5]:28810 "EHLO
	videira.terra.com.br") by vger.kernel.org with ESMTP
	id <S261622AbSJUU1I>; Mon, 21 Oct 2002 16:27:08 -0400
Subject: Re: System call wrapping
From: Lucio Maciel <abslucio@terra.com.br>
To: Rik van Riel <riel@conectiva.com.br>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L.0210211812240.22993-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0210211812240.22993-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 21 Oct 2002 17:33:14 -0300
Message-Id: <1035232394.21145.8.camel@walker>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 17:14, Rik van Riel wrote:
> 
> Maybe you could use the Linux Security Module hooks for
> open() and exec() to pass a request to your virus scan
> software ?
> 
> Note that this kernel module needs to be GPL, due to the
> fact that it's a derived work of the kernel itself. This
> only applies to the kernel module that asks the virus
> scanner to check the files for virusses, not necessarily
> the virus scanner itself.
> 
> Rik
> -- 
Hello...

Where can i find some information or documentation about this ????

thanks
-- 
::: Lucio F. Maciel
::: abslucio@terra.com.br
::: icq 93065464
::: Absoluta.net

