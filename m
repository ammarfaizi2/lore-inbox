Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129331AbRBSOHp>; Mon, 19 Feb 2001 09:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129513AbRBSOHf>; Mon, 19 Feb 2001 09:07:35 -0500
Received: from t2.redhat.com ([199.183.24.243]:64496 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S129331AbRBSOHW>; Mon, 19 Feb 2001 09:07:22 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [LONG RANT] Re: Linux stifles innovation... 
In-Reply-To: Your message of "Mon, 19 Feb 2001 14:11:52 +0100."
             <20010219141152.H6494@almesberger.net> 
Date: Mon, 19 Feb 2001 14:07:17 +0000
Message-ID: <24970.982591637@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I suspect part of the problem with commercial driver support on Linux is that
the Linux driver API (such as it is) is relatively poorly documented and seems
to change almost on a week-by-week basis anyway. I've done my share of chasing
the current kernel revision with drivers that aren't part of the kernel tree:
by the time you update the driver to work with the current kernel revision,
there's a new one out, and the driver doesn't compile with it.

David
