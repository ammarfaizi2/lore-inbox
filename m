Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289551AbSBEOvf>; Tue, 5 Feb 2002 09:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289556AbSBEOv0>; Tue, 5 Feb 2002 09:51:26 -0500
Received: from sun.fadata.bg ([80.72.64.67]:61190 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S289549AbSBEOvU>;
	Tue, 5 Feb 2002 09:51:20 -0500
To: Jens Axboe <axboe@suse.de>
Cc: Ralf Oehler <R.Oehler@GDAmbH.com>, Scsi <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>,
        Jens Axboe <axboe@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: one-line-patch against SCSI-Read-Error-BUG()
In-Reply-To: <XFMail.20020205153210.R.Oehler@GDAmbH.com>
	<20020205152434.A16105@suse.de>
X-No-CC: Reply to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <20020205152434.A16105@suse.de>
Date: 05 Feb 2002 16:52:59 +0200
Message-ID: <871yg07zg4.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jens" == Jens Axboe <axboe@suse.de> writes:

Jens> On Tue, Feb 05 2002, Ralf Oehler wrote:
>> Hi, List
>> 
>> I think, I found a very simple solution for this annoying BUG().

Jens> You fail to understand that the BUG triggering indicates that their is a
Jens> BUG _somewhere_ -- the triggered BUG is not the bug itself, of course,
Jens> that would be stupid :-)

Erm, having a BUG() somewhere can be a bug by itself ;)

I think that's what he meant (regardless if he was right or not). 


