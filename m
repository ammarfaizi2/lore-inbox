Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278714AbRJXStg>; Wed, 24 Oct 2001 14:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278713AbRJXSt0>; Wed, 24 Oct 2001 14:49:26 -0400
Received: from sith.mimuw.edu.pl ([193.0.97.1]:45318 "EHLO sith.mimuw.edu.pl")
	by vger.kernel.org with ESMTP id <S278714AbRJXStR>;
	Wed, 24 Oct 2001 14:49:17 -0400
Date: Wed, 24 Oct 2001 20:49:13 +0200
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: "David S. Miller" <davem@redhat.com>
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: acenic breakage in 2.4.13-pre
Message-ID: <20011024204913.A18191@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
	"David S. Miller" <davem@redhat.com>, jgarzik@mandrakesoft.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011024.093627.68149691.davem@redhat.com>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux 2.4.7 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2001, David S. Miller wrote:

>    From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
>    Date: Wed, 24 Oct 2001 18:04:14 +0200
> 
>    On Wed, 24 Oct 2001, David S. Miller wrote:
>    
>    > Do you have CONFIG_HIGHMEM enabled?  If so, please try with
>    > it turned off.
>    
>    Nope. No HIGHMEM here.
> 
> Thanks, one more question :-)  What compiler is on your
> machine where this driver was built?  Are you using RH7.1
> or some variant of gcc-3.x by chance?

No. It's plain old egcs 1.1.2 (gcc 2.91.66). I can try with gcc 2.95.x
but 2.96 or 3.x are no-no for me :)

Jan
-- 
Jan Rêkorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, MANIAC              |                   -- TROOPS by Kevin Rubio
