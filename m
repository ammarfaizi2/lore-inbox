Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276519AbRJCQu4>; Wed, 3 Oct 2001 12:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276522AbRJCQuq>; Wed, 3 Oct 2001 12:50:46 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:44427 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S276519AbRJCQue>; Wed, 3 Oct 2001 12:50:34 -0400
Date: Wed, 3 Oct 2001 09:52:58 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: Harald Dunkel <harri@synopsys.COM>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: CPU Temperature?
In-Reply-To: <3BBB4011.C4DC2527@Synopsys.COM>
Message-ID: <Pine.LNX.4.33.0110030949200.23518-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, you want to look at the lm_sensors project...

http://www.netroedge.com/~lm78/

the temperature voltage and fan sensors on your mainboard should be
accessible without to much trouble...

joelja

On Wed, 3 Oct 2001, Harald Dunkel wrote:

> Hi folks,
>
> Is there a standard interface to watch the temperature of the CPU (e.g.
> Athlon Thunderbird)? Or is this a feature of my main board?
>
> How can I access the CPU temperature, fan speed etc. from Linux?
> Or is this too hardware dependent to implement a common interface?
>
>
> Regards
>
> Harri
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


