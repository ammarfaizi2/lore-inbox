Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281810AbRK0XNE>; Tue, 27 Nov 2001 18:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282984AbRK0XMy>; Tue, 27 Nov 2001 18:12:54 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:8423 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S281810AbRK0XMh>; Tue, 27 Nov 2001 18:12:37 -0500
Message-ID: <3C041E4B.CA4D7A8A@oracle.com>
Date: Wed, 28 Nov 2001 00:14:19 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.1-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Massimo Dal Zotto <dz@cs.unitn.it>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org, alan@redhat.com,
        marcelo@conectiva.com.br
Subject: Re: [PATCH] latest version of i8k driver
In-Reply-To: <200111261111.fAQBBUpG011037@dizzy.dz.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Massimo Dal Zotto wrote:
> 
> Hi,
> 
> here is the latest version of the i8k driver. I have changed the i8k_probe
> again and now it loads cleanly on most Dell Inspiron and Latitude laptops.
> I have also disabled by default the power status since this information is
> already available from apm. The patch is against linux-2.4.15.

[snipped patch]

Confirmed that it loads cleanly on my Latitude CPx J750GT (no more need
 to "force=1") and it still works. I actually tested it on 2.5.1-pre2.

--alessandro

 "we live as we dream alone / to break the spell we mix with the others
  we were not born in isolation / but sometimes it seems that way"
     (R.E.M., live intro to 'World Leader Pretend')
