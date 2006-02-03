Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWBCDf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWBCDf4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 22:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWBCDf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 22:35:56 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:12165 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964901AbWBCDf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 22:35:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=ERZo0TPUedilZTDKqPPCwZ9x+6s2e+TCsz2TQ3Kb4seJJLCBXCqNHDdQY3X3XhMUO7/yh/msXrzNPbQ47xL4gwa2tzKMA81HYze8Zzcp6KEPklnSKUoNyszi32XuJ4VtYCkb6ppxhRPfPdOmvsUbVa2i1He2RN2014CQliRvDJk=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
Date: Thu, 2 Feb 2006 22:35:43 -0500
User-Agent: KMail/1.8.3
Cc: Rene Herman <rene.herman@keyaccess.nl>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <43D114A8.4030900@wolfmountaingroup.com> <200602020139.26065.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <12C8ECBA-B36E-454A-9C03-8990EA5C4609@mac.com>
In-Reply-To: <12C8ECBA-B36E-454A-9C03-8990EA5C4609@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602022235.43898.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 February 2006 01:57, Kyle Moffett wrote:
> But see, even assuming the really odd case of a project consisting of  
> one file, the GPL, that project would be completely GPL compatible.   
> As the license specifies the licensing terms for the project (IE: the  
> GPL), it may not legally be modified _even_ _under_ _copyright_ _law_  
> (because it's the project license).

Well ok, but modified copies of it (that aren't the license) could be
made. For the sake of argument, imaging copying the preamble into
another file and adding a few paragraphs there, with a prominent notice of
your modifications. This is allowed by the GPL (the License is the same,
and you're not violating the other terms either as far as I can see). But
it is not allowed by the license for the text of the GPL. Hence the
problem. It's an odd squirrelly corner case of the sort that cause licenses
to bloat up with verbiage. 

The out is if the license file is not a portion of the program, in which
case section 2 of the GPL doesn't apply. I think this is what Alan Cox
is arguing. However, while it would be convenient if the License text
wasn't considered part of the program, I'm not sure that reasoning
would hold up in court.

It's also a complete non-issue: both because no-one is going to actually
object to the text of the GPL being there, and because it can be replaced
with a simple link in the extremely unlikely event that the need arises.

Andrew Wade
