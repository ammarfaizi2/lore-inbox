Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264586AbRFPF6B>; Sat, 16 Jun 2001 01:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264587AbRFPF5v>; Sat, 16 Jun 2001 01:57:51 -0400
Received: from ns.suse.de ([213.95.15.193]:49680 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S264586AbRFPF5k>;
	Sat, 16 Jun 2001 01:57:40 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac14
In-Reply-To: <200106162255.SAA02119@olimpo.networx.com.br.suse.lists.linux.kernel> <E15B0vv-000780-00@the-village.bc.nu.suse.lists.linux.kernel> <15146.33742.299279.102372@pizda.ninka.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 16 Jun 2001 07:57:33 +0200
In-Reply-To: "David S. Miller"'s message of "15 Jun 2001 23:57:21 +0200"
Message-ID: <oupzob9q84y.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> Alan Cox writes:
>  > Because right now I dont consider the 2.4.6 page cache ext2 stuff safe
>  > enough to merge. I'm letting someone else be the sucide squad.. so far it
>  > looks like it is indeed fine but I want to wait and see more yet
> 
> If it means anything it has already withstanded a few
> cerebus-->fsck_check-->cerebus rounds on machines here
> in my lab.

... it also seems to make ppc not boot anymore.

-Andi
