Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129477AbQLTKDG>; Wed, 20 Dec 2000 05:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129543AbQLTKC4>; Wed, 20 Dec 2000 05:02:56 -0500
Received: from mel.alcatel.fr ([212.208.74.132]:1392 "EHLO mel.alcatel.fr")
	by vger.kernel.org with ESMTP id <S129477AbQLTKCx>;
	Wed, 20 Dec 2000 05:02:53 -0500
Message-ID: <3A407C5F.C8BC2802@vz.cit.alcatel.fr>
Date: Wed, 20 Dec 2000 10:31:12 +0100
From: Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr>
X-Mailer: Mozilla 4.7 [fr] (WinNT; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Announce: modutils 2.3.23 is available
In-Reply-To: <3249.977272993@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

About Standard aliases:
> modprobe -c
...
alias ppp-compress-21 bsd_comp
...

Why bsd_comp is the standard alias?
/src/linux/Configure.help says that

The PPP Deflate compression method ("PPP Deflate compression",
  above) is preferable to BSD-Compress, because it compresses better
  and is patent-free.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
