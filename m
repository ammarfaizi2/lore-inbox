Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRBXVrf>; Sat, 24 Feb 2001 16:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129627AbRBXVrZ>; Sat, 24 Feb 2001 16:47:25 -0500
Received: from smtp-rt-5.wanadoo.fr ([193.252.19.159]:15815 "EHLO
	caroubier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129631AbRBXVrM>; Sat, 24 Feb 2001 16:47:12 -0500
Message-ID: <3A982B87.3040201@wanadoo.fr>
Date: Sat, 24 Feb 2001 22:45:43 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en, fr-fr
MIME-Version: 1.0
To: jeisen@mindspring.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Odd network problems
In-Reply-To: <Pine.LNX.4.21.0102241235310.30688-100000@dominia>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Eisenstein wrote:


> Here is a partial list of sites that I have had problems with. Note that
> once I find one of these sites, it is consistantly unreachable, even with
> sites found months ago.

i had a try with Linux-2.4.2 Mozilla 0.8
> www.codewarrioru.com
time out answer (pingable however)

> www.backwire.com
connection refused with ECN.
echo '0' > tcp_ecn makes it reachable. Mozilla sucks (CPU99%) and does
not display the page in a reasonable time (maybe a problem i have with
java and glibc-2.2.2)

> www.counterpane.com
no problem with this one.

> www.zip2it.com
un-resolved (could it be www.zip2.com)


-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

