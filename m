Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265150AbSJPQLD>; Wed, 16 Oct 2002 12:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265152AbSJPQLD>; Wed, 16 Oct 2002 12:11:03 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:44455 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265150AbSJPQLA>; Wed, 16 Oct 2002 12:11:00 -0400
Date: Wed, 16 Oct 2002 09:16:47 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Jeff Dike <jdike@karaya.com>
Cc: Oleg Drokin <green@namesys.com>,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] UML and 2.5.43
Message-ID: <20021016161647.GA1414@beaverton.ibm.com>
Mail-Followup-To: Jeff Dike <jdike@karaya.com>,
	Oleg Drokin <green@namesys.com>,
	user-mode-linux-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20021016125037.A6413@namesys.com> <200210161127.GAA02008@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210161127.GAA02008@ccure.karaya.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Oleg I had found this late last night. It is good someone else
was seeing it also.


Jeff Dike [jdike@karaya.com] wrote:
> green@namesys.com said:
> >     Probably attached patch is one of the right things to do.
> >     As additional bonus it fixes uninitialised variable usage ;) 
> 
> Cool, Mike Anderson was complaining about that, and I hadn't got around to
> looking at it yet.
> 
> 				Jeff
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-andmike
--
Michael Anderson
andmike@us.ibm.com

