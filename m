Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317606AbSHHPjJ>; Thu, 8 Aug 2002 11:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317610AbSHHPjJ>; Thu, 8 Aug 2002 11:39:09 -0400
Received: from pop017pub.verizon.net ([206.46.170.210]:23034 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP
	id <S317606AbSHHPjI>; Thu, 8 Aug 2002 11:39:08 -0400
Message-ID: <3D529154.8090304@verizon.net>
Date: Thu, 08 Aug 2002 11:42:12 -0400
From: "Anthony Russo., a.k.a. Stupendous Man" <anthony.russo@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 BUG in page_alloc.c:91
References: <Pine.LNX.4.44L.0208072350060.23404-100000@imladris.surriel.com> <3D51DD80.6070501@verizon.net> <20020808075536.GB943@alpha.home.local>
X-Enigmail-Version: 0.62.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I'm sorry, but I don't have an NVidia card, and I definitely didn't
load and unload that module. It must be something else.

AFAIK, the only proprietary module that is loaded is the fa312,
which is a driver for my ethernet card,  which is still loaded
and has never caused any problems for the 1.5 years I've used it.

This problem is new with the 2.4.19 kernel.

-- tony

Willy Tarreau wrote:

>On Wed, Aug 07, 2002 at 10:54:56PM -0400, Anthony Russo., a.k.a. Stupendous Man wrote:
>  
>
>> I don't believe I have any "proprietary" modules loaded, but
>>here is the output of lsmod:
>>    
>>
>
>but a proprietary module *has* been loaded and then removed before your
>lsmod, right ? wouldn't it be nvidia's ? the oops ressembles the one many
>nvidia users experiment. 
>
>Regards,
>Willy
> 
>
>  
>

-- 
"Surrender to the Void."
<http://162.83.145.190:8080/%7Eapr/surrenderToTheVoid.mp3> -- John Lennon


