Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130461AbRABOLg>; Tue, 2 Jan 2001 09:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130762AbRABOL0>; Tue, 2 Jan 2001 09:11:26 -0500
Received: from hermes.mixx.net ([212.84.196.2]:2566 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130461AbRABOLU>;
	Tue, 2 Jan 2001 09:11:20 -0500
Message-ID: <3A51D9BF.23C42DFE@innominate.de>
Date: Tue, 02 Jan 2001 14:38:07 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Vedran Rodic <vedran@renata.irb.hr>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-prerelease problems (it corrupted my ext2 filesystem)
In-Reply-To: <20010102131507.A7573@renata.irb.hr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you provide details of your configuration?

Vedran Rodic wrote:
> I was using 2.4.0-prerelease without extra patches and I experienced some
> heavy (ext2) file system corruption. I was grabbing some video using bttv at
> the time. Kernel didn't oops, but processess just started terminating.
> 
> Here is a the interesting part from my logs:
> 
> Bad swap file entry 5c5b6256
> VM: killing process qtvidcap
> swap_free: Trying to free nonexistent swap-page
> last message repeated 23 times
> swap_free: Trying to free swap from unused swap-device
> swap_free: Trying to free nonexistent swap-page
> last message repeated 266 times
> Bad swap file entry 272c2e24
> VM: killing process pppd
> swap_free: Trying to free nonexistent swap-page
> last message repeated 30 times

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
