Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271226AbRIFPSH>; Thu, 6 Sep 2001 11:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271278AbRIFPR5>; Thu, 6 Sep 2001 11:17:57 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:15793 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271226AbRIFPRs>;
	Thu, 6 Sep 2001 11:17:48 -0400
Date: Thu, 06 Sep 2001 16:18:06 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: phillips@bonn-fries.net, riel@conectiva.com.br, jaharkes@cs.cmu.edu,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: page_launder() on 2.4.9/10 issue
Message-ID: <598996561.999793086@[10.132.112.53]>
In-Reply-To: <20010906171049.4d40da02.skraw@ithnet.com>
In-Reply-To: <20010906171049.4d40da02.skraw@ithnet.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Thursday, September 06, 2001 5:10 PM +0200 Stephan von Krawczynski 
<skraw@ithnet.com> wrote:

> (or default = 1024) gives such a ridicolously bad
> performance

I know. I am trying to ensure we have the problem definitively
identified, either from /proc/memareas, or by showing it
goes away if you change rsize/wsize. I am NOT proposing
it as a fix.

--
Alex Bligh
