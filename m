Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280784AbRKGNEz>; Wed, 7 Nov 2001 08:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280786AbRKGNEp>; Wed, 7 Nov 2001 08:04:45 -0500
Received: from barn.holstein.com ([198.134.143.193]:1043 "EHLO holstein.com")
	by vger.kernel.org with ESMTP id <S280784AbRKGNEZ>;
	Wed, 7 Nov 2001 08:04:25 -0500
Date: Wed, 7 Nov 2001 07:13:07 -0500
Message-Id: <200111071213.fA7CD7b15181@pcx4168.holstein.com>
From: "Todd M. Roy" <troy@holstein.com>
To: mhaque@haque.net
Cc: rml@tech9.net, mfedyk@matchmail.com, jimmy@mtc.dhs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <E290D3DA-D26B-11D5-A0A2-00306569F1C6@haque.net>
	(mhaque@haque.net)
Subject: Re: kernel 2.4.14 compiling fail for loop device
Reply-To: troy@holstein.com
In-Reply-To: <E290D3DA-D26B-11D5-A0A2-00306569F1C6@haque.net>
X-MIMETrack: Itemize by SMTP Server on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 11/07/2001 08:03:56 AM,
	Serialize by Router on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 11/07/2001 08:03:57 AM,
	Serialize complete at 11/07/2001 08:03:57 AM
X-Priority: 3 (Normal)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I did, and used a looped an iso image, eventually my
computer froze up.  Using the actual cd, it did not.  So my
personal answer would be no.

-- todd --

>  > Nope, it was added post-pre8 to final.  The deactivate_page function was
>  > removed completely.
>  
>  Safe to remove those two lines from loop.c? Other calls of deactive_page 
>  were just removed it seemed.
>  
>  --
>  
>  =====================================================================
>  Mohammad A. Haque                              http://www.haque.net/
>                                                  mhaque@haque.net
>  
>     "Alcohol and calculus don't mix.             Developer/Project Lead
>      Don't drink and derive." --Unknown          http://wm.themes.org/
>                                                  batmanppc@themes.org
>  =====================================================================
>  
>  -
>  To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at  http://www.tux.org/lkml/
>  
