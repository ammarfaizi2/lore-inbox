Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284998AbRL3VBy>; Sun, 30 Dec 2001 16:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284987AbRL3VBp>; Sun, 30 Dec 2001 16:01:45 -0500
Received: from t2.redhat.com ([199.183.24.243]:53744 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S284998AbRL3VB3>; Sun, 30 Dec 2001 16:01:29 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011229191444.A16473@suse.de> 
In-Reply-To: <20011229191444.A16473@suse.de> 
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1-dj8 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 30 Dec 2001 21:01:28 +0000
Message-ID: <1365.1009746088@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(for the benefit of the peanut gallery)

davej@suse.de said:
> o   Remove bogus <asm/segment.h> includes.		(David Woodhouse) 

In a fit of stupidity, I sent you the wrong patch - the one I sent was the
original version which removed far too many instances of asm/segment.h.

I've just sent you the correct one.

--
dwmw2


