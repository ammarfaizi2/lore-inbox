Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132775AbRDNHaR>; Sat, 14 Apr 2001 03:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132776AbRDNHaI>; Sat, 14 Apr 2001 03:30:08 -0400
Received: from relay03.valueweb.net ([216.219.253.237]:2316 "EHLO
	relay03.valueweb.net") by vger.kernel.org with ESMTP
	id <S132775AbRDNH3v>; Sat, 14 Apr 2001 03:29:51 -0400
Message-ID: <3AD7FDE4.3F7D17A7@opersys.com>
Date: Sat, 14 Apr 2001 03:36:04 -0400
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Crispin Cowan <crispin@wirex.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux Security Module Interface
In-Reply-To: <3AD3A86A.6ACD8B05@wirex.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Crispin Cowan wrote:
> 
> Modules that can be loaded, or not, are the obvious solution, but the
> current LKM does not export sufficient hooks to support many security
> mechanisms.

Have you taken a look at the hooks provided with the patch provided with
the Linux Trace Toolkit (http://www.opersys.com/LTT).

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karym@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
