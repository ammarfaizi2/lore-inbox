Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264904AbSJVU5N>; Tue, 22 Oct 2002 16:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264901AbSJVU5N>; Tue, 22 Oct 2002 16:57:13 -0400
Received: from almesberger.net ([63.105.73.239]:42246 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S264904AbSJVU5I>; Tue, 22 Oct 2002 16:57:08 -0400
Date: Tue, 22 Oct 2002 18:02:48 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Richard J Moore <richardj_moore@uk.ibm.com>
Cc: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 Ready list - Kernel Hooks
Message-ID: <20021022180248.A2599@almesberger.net>
References: <OFB11C3B1B.7077B872-ON80256C59.0043FA55@portsmouth.uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFB11C3B1B.7077B872-ON80256C59.0043FA55@portsmouth.uk.ibm.com>; from richardj_moore@uk.ibm.com on Mon, Oct 21, 2002 at 01:24:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard J Moore wrote:
> Kernel Hooks is also ready,

I'm a bit puzzled as to what those hooks accomplish. They look
like a less flexible but a little faster and more portable
variant of kprobes.

Is this what they are ? If yes, does it really make sense to
have two so similar mechanisms for tapping into execution flows
in the kernel ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
