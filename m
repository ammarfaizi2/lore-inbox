Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287860AbSBCXBA>; Sun, 3 Feb 2002 18:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287862AbSBCXAu>; Sun, 3 Feb 2002 18:00:50 -0500
Received: from mx2.elte.hu ([157.181.151.9]:22152 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S287860AbSBCXAc>;
	Sun, 3 Feb 2002 18:00:32 -0500
Date: Mon, 4 Feb 2002 00:00:30 +0100
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 NFS hangup
Message-ID: <20020203230030.GA14478@csoma.elte.hu>
In-Reply-To: <20020203202251.GA22797@csoma.elte.hu> <shsbsf61di3.fsf@charged.uio.no> <20020203213422.GA703@csoma.elte.hu> <15453.48475.123973.610574@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15453.48475.123973.610574@charged.uio.no>
User-Agent: Mutt/1.3.27i
X-Accept-Language: en, hu
From: "=?iso-8859-2?Q?Burj=E1n_G=E1bor?=" 
	<buga+dated+1013036430.1fd862@elte.hu>
X-Delivery-Agent: TMDA/0.43 (Python 2.1.1+; linux2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, Trond Myklebust wrote:

> Are you seeing any kernel log messages about 'Tx FIFO error!' that
> might indicate that particular code is getting triggered?

No, nothing logged except the NFS related messages.  However, after NFS
hangup I cannot scp from the host, but ssh works...   I am beginning to
think that this is not an NFS issue.  Then what could it be?

	buga
