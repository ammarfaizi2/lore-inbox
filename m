Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVBZAou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVBZAou (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 19:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVBZAot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 19:44:49 -0500
Received: from nibbel.kulnet.kuleuven.ac.be ([134.58.240.41]:2745 "EHLO
	nibbel.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262105AbVBZAnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 19:43:55 -0500
Message-ID: <421FC534.1000602@mech.kuleuven.ac.be>
Date: Sat, 26 Feb 2005 01:39:16 +0100
From: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: takis@lumumba.luc.ac.be, prism54-devel@prism54.org,
       linux-kernel@vger.kernel.org
Subject: Re: prism54 not releasing region
References: <20050226010126.A28793@lumumba.luc.ac.be> <20050225164054.2c512daf.akpm@osdl.org>
In-Reply-To: <20050225164054.2c512daf.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Panagiotis Issaris <takis@lumumba.luc.ac.be> wrote:
>  
>
>>To my newbie eye it looked as if the region requested at line 154
>>weren't released in case of the line 166 failure handling. Is
>>my assumption right?
>>    
>>
>
>It is.  I can take care of this patch for you, thanks.
>  
>
Great! :-) Thanks!

With friendly regards,
Takis

-- 
  K.U.Leuven, Mechanical Eng.,  Mechatronics & Robotics Research Group
  http://people.mech.kuleuven.ac.be/~pissaris/

