Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129382AbRBIVTj>; Fri, 9 Feb 2001 16:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130113AbRBIVTS>; Fri, 9 Feb 2001 16:19:18 -0500
Received: from esteel10.client.dti.net ([209.73.14.10]:14465 "EHLO
	nynews01.e-steel.com") by vger.kernel.org with ESMTP
	id <S129292AbRBIVTK>; Fri, 9 Feb 2001 16:19:10 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
Newsgroups: e-steel.mailing-lists.linux.linux-kernel
Subject: Re: problem in BOGOmips
Date: 09 Feb 2001 16:19:04 -0500
Organization: e-STEEL Netops news server
Message-ID: <m3ae7vlflj.fsf@shookay.e-steel.com>
In-Reply-To: <3A6C802C.9380961A@earthlink.net> <Pine.LNX.4.04.10102100210150.12228-100000@csews12.cse.iitk.ac.in>
NNTP-Posting-Host: shookay.e-steel
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: nynews01.e-steel.com 981753457 19563 192.168.3.43 (9 Feb 2001 21:17:38 GMT)
X-Complaints-To: news@nynews01.e-steel.com
NNTP-Posting-Date: 9 Feb 2001 21:17:38 GMT
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gashish@cse.iitk.ac.in (Ashish Gupta) writes:

> Hi,
> 	I want to use bogomips as the indicator of CPU capability for
> different architectures. I have found following values from /proc/cpuinfo
> for different CPUs.

You got your answer. Try pronounce bogomips and you will hear bogo like in
bogus. The Bogomips don't represent anything but a way to have a good delay
mechanism... So you can't compare them between CPUs!
-- 
Mathieu CHOUQUET-STRINGER              E-Mail : mchouque@e-steel.com
     Learning French is trivial: the word for horse is cheval, and
               everything else follows in the same way.
                        -- Alan J. Perlis
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
