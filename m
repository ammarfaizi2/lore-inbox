Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289084AbSBSArb>; Mon, 18 Feb 2002 19:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289089AbSBSArW>; Mon, 18 Feb 2002 19:47:22 -0500
Received: from holomorphy.com ([216.36.33.161]:25999 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S289084AbSBSArJ>;
	Mon, 18 Feb 2002 19:47:09 -0500
Date: Mon, 18 Feb 2002 16:46:51 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        riel@surriel.com, davem@redhat.com, rwhron@earthlink.net
Subject: Re: [PATCH] [rmap] operator-sparse Fibonacci hashing of waitqueues
Message-ID: <20020219004651.GG3511@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org, riel@surriel.com, davem@redhat.com,
	rwhron@earthlink.net
In-Reply-To: <20020217090111.GF832@holomorphy.com> <E16cwJZ-0000jZ-00@starship.berlin> <20020219003450.GF3511@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020219003450.GF3511@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2002 at 04:34:50PM -0800, William Lee Irwin III wrote:
> where it's 1's all the way down. Some additional study also revealed
> that how close the continued fraction of a number is to phi is related
> to how uniform the spectrum is. For brevity, I write continued fractions
> in-line, for instance, 0,1,1,1,1,... for phi, or 0,1,2,3,4,... for
> 
> 0 + 1
>    -----
>    1 + 2
>       -----
>       1 + 3
>          -----
>          1 + 4
>             ....

doh! Sorry, I just woke up

0 + 1
   -----
   1 + 1
      -----
      2 + 1
         -----
         3 + 1
            -----
            4 + 1
               ...


Cheers,
Bill
