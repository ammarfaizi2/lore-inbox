Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288801AbSBYUJp>; Mon, 25 Feb 2002 15:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288748AbSBYUHp>; Mon, 25 Feb 2002 15:07:45 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:46933 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S289749AbSBYUH1>; Mon, 25 Feb 2002 15:07:27 -0500
Date: Mon, 25 Feb 2002 20:09:50 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18
In-Reply-To: <Pine.LNX.4.21.0202251537080.31438-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0202252007540.7105-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Marcelo Tosatti wrote:
> 
> Finally, 2.4.18. No changes between it and -rc4.
> 
> final:
> 
> - No changes have been made between -final 
>   and -rc4.
> 
> rc4:
> 
> - Load code did not set personality for
>   binaries without an interpreter: This was 
>   breaking static apps on several archs		(Tom Gall)

Am I imagining it, or has this -rc4 fix gone missing in final?

Hugh

