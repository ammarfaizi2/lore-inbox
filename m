Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWHKKJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWHKKJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 06:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWHKKJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 06:09:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:35333 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751101AbWHKKJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 06:09:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=efyum5VZrGdBVx+R80knpVkyddtdMVpEHowcO1gzRPo75dXT2yt6NxrhnfknRMZxKfuwFiS7FRxjtkcBCbz2KII9BaWM7+9Gd+B7fqmRtRSCAoToclAa2pFZGDLXh5ZI8X/++W+yLcMiSOdEVdbX0N5q3XBNC1VQbBHm3oWHJwo=
Message-ID: <44DC5765.1070102@gmail.com>
Date: Fri, 11 Aug 2006 12:09:18 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Dumb Question
References: <44DBFF8A.4020604@perkel.com> <44DC135A.5010407@perkel.com> <Pine.LNX.4.61.0608110802000.21588@yvahk01.tjqt.qr> <44DC1E21.1020805@perkel.com> <Pine.LNX.4.61.0608110916580.11836@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608110916580.11836@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>> I figured it out - however - the files to download to compile the
>>>> kernel should be accessible from the front page of the web site.
>>> They are - http://kernel.org/ right on the front. (Click either 2.6.17.8
>>> or "F", depending on what you need).
>>>
>> But that doesn't let me compile 2.6.18.

Nothing on the world let you compile 2.6.18, it wasn't released yet ;).

> Get a compiler? (And the "F" file.)
> 
>> And the patch can't be applied to the 2.6.17.8 kernel.

See
Documentation/applying-patches.txt
in linux source directory (and other userful docs there -- 00-INDEX and HOWTO as 
a beginning)

regards.
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
