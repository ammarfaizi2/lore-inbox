Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130896AbRBLNHo>; Mon, 12 Feb 2001 08:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130904AbRBLNHe>; Mon, 12 Feb 2001 08:07:34 -0500
Received: from fisica.ufpr.br ([200.17.209.129]:48636 "EHLO
	hoggar.fisica.ufpr.br") by vger.kernel.org with ESMTP
	id <S130896AbRBLNHY>; Mon, 12 Feb 2001 08:07:24 -0500
From: Carlos Carvalho <carlos@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14983.57112.764892.252275@hoggar.fisica.ufpr.br>
Date: Mon, 12 Feb 2001 11:03:20 -0200
To: Doug Ledford <dledford@redhat.com>, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre9 Kernel panic aic7xxx
In-Reply-To: <3A84640B.6F0D31D5@redhat.com>
In-Reply-To: <3A8450B0.D2B85951@dial.eunet.ch>
	<3A84640B.6F0D31D5@redhat.com>
X-Mailer: VM 6.90 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford (dledford@redhat.com) wrote on 9 February 2001 16:41:
 >The latest patch I sent Alan had both the hosts.c fix and some other fixes, so
 >I'm thinking it hasn't made it into his 2.2.19pre9 kernel.  The next one
 >should work fine as far as aic7xxx is concerned.

I think you should post your patch here, because pre9 is unusable
without it. Well, at least for me, but this is the first time in
almost 9 years that this happens. I have fairly standard 7890, in
2940, 2940UW adaptecs. If it doesn't work for me, it's likely to not
work for many others. Since pre9 is urgent because of the security
patches, it'd be good to upgrade as soon as possible.

Another alternative is that Alan posts the security part separately.
Or that he releases pre10, including all Trond's fixes for nfs as
well :-) :-)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
