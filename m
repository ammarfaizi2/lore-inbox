Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278514AbRJVLM6>; Mon, 22 Oct 2001 07:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278517AbRJVLMs>; Mon, 22 Oct 2001 07:12:48 -0400
Received: from lilly.ping.de ([62.72.90.2]:46350 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S278514AbRJVLMi>;
	Mon, 22 Oct 2001 07:12:38 -0400
Date: 22 Oct 2001 13:08:58 +0200
Message-ID: <20011022130858.A1699@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Rik van Riel" <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13pre5aa1
In-Reply-To: <20011021211726.A476@planetzork.spacenet> <Pine.LNX.4.33L.0110211749310.3690-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33L.0110211749310.3690-100000@imladris.surriel.com>; from riel@conectiva.com.br on Sun, Oct 21, 2001 at 05:50:30PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 05:50:30PM -0200, Rik van Riel wrote:
> On 21 Oct 2001 jogi@planetzork.ping.de wrote:
> 
> > 2.4.12-ac3:       4:52.16   5:21.15   6:22.85   10:26.70
> 
> > If further infos are interesting just send me an email.
> 
> It would be cool if you could test this with 2.4.12-ac3 and
> my -vmpatch and -freeswap patches against this kernel ;)
> 
> Patches on http://www.surriel.com/patches/

As promised here are the results for 2.4.12-ac3 + vmpatch
and freeswap.

2.4.12-ac3: 8:20.46
2.4.12-ac3: 6:36.67
2.4.12-ac3: 6:37.61
2.4.12-ac3: 7:36.24
2.4.12-ac3: 7:21.24

These times are for -j100.

Kind regards,

   Jogi

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
