Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129749AbQLYQbg>; Mon, 25 Dec 2000 11:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130397AbQLYQb0>; Mon, 25 Dec 2000 11:31:26 -0500
Received: from cicero1.cybercity.dk ([212.242.40.4]:28939 "HELO
	cicero1.cybercity.dk") by vger.kernel.org with SMTP
	id <S129749AbQLYQbU>; Mon, 25 Dec 2000 11:31:20 -0500
Date: Mon, 25 Dec 2000 17:01:32 +0100
From: Jens Axboe <axboe@suse.de>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: Dave Gilbert <gilbertd@treblig.org>, linux-kernel@vger.kernel.org
Subject: Re: css hang; somewhere between test12 and test13pre4ac2
Message-ID: <20001225170132.E303@suse.de>
In-Reply-To: <Pine.LNX.4.10.10012242340530.666-100000@tardis.home.dave> <20001225121037.B303@suse.de> <3A476CC0.45AD0033@haque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A476CC0.45AD0033@haque.net>; from mhaque@haque.net on Mon, Dec 25, 2000 at 10:50:24AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 25 2000, Mohammad A. Haque wrote:
> This is confirmed. mounting css dics causes oops. non-css discs work
> fine. 
> 
> oops coming soon.

Thanks. If it's the cdrom_log_sense oops, please try also with
previously sent patch.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
