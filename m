Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268832AbRHPUTI>; Thu, 16 Aug 2001 16:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268834AbRHPUS6>; Thu, 16 Aug 2001 16:18:58 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:45466 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S268832AbRHPUSm>; Thu, 16 Aug 2001 16:18:42 -0400
Message-ID: <3B7C2AED.F8882B5A@idcomm.com>
Date: Thu, 16 Aug 2001 14:19:57 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Optionally let Net Devices feed Entropy
In-Reply-To: <20010816190255.A17095@se1.cogenit.fr> <212453020.997993720@[169.254.45.213]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux-kernel wrote:
> 
> >> What is experimental about it?
> >
> > The implicit-and-should-be-debated-in-2.5 assumption that the entropy
> > estimate still makes sense ?
> 
> As opposed to the huge amount of sense it currently makes to
> collect it depending on your NIC manufacturer, as opposed to
> dependent upon a config option?
> 
> If you mean that the option should be labelled 'not for
> the paranoid' I agree. The patch does that. 'Experimental'
> means the code may crash, or perform other than as advertized.
> 
> --
> Alex Bligh
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

It would be interesting if an option were possible for entropy pool via
loopback traffic.

D. Stimits, stimits@idcomm.com
