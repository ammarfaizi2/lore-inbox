Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbTBGOvX>; Fri, 7 Feb 2003 09:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265305AbTBGOvX>; Fri, 7 Feb 2003 09:51:23 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:25536 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265285AbTBGOvV>;
	Fri, 7 Feb 2003 09:51:21 -0500
Date: Fri, 7 Feb 2003 14:57:07 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: P@draigBrady.com
Cc: c1cc10 <c1cc10@autistici.org>, linux-kernel@vger.kernel.org
Subject: Re: Cyrix III processor and kernel boot problem
Message-ID: <20030207145707.GA23008@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>, P@draigBrady.com,
	c1cc10 <c1cc10@autistici.org>, linux-kernel@vger.kernel.org
References: <3E43C79A.2010506@autistici.org> <20030207141052.GA22687@codemonkey.org.uk> <3E43C003.7090602@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E43C003.7090602@draigBrady.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 02:17:39PM +0000, P@draigBrady.com wrote:

 > >as a sidenote, the new C3s (Nehemiah) now have CMOV.
 > but no 3dnow so older C3 specific kernels don't work!

Yep. Dropped in favour of SSE.  I have a patch to add an extra
config option for the C3-2. It's going to Linus/Marcelo later
this afternoon.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
