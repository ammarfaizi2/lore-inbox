Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318208AbSHFACz>; Mon, 5 Aug 2002 20:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318354AbSHFACz>; Mon, 5 Aug 2002 20:02:55 -0400
Received: from sabre.velocet.net ([216.138.209.205]:30473 "HELO
	sabre.velocet.net") by vger.kernel.org with SMTP id <S318208AbSHFACy>;
	Mon, 5 Aug 2002 20:02:54 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Gregory Stark <gsstark@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Oopses
References: <87sn1sgbcp.fsf@stark.dyndns.tv>
	<1028593411.18130.131.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1028593411.18130.131.camel@irongate.swansea.linux.org.uk>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
Date: 05 Aug 2002 20:06:30 -0400
Message-ID: <87hei8g8ah.fsf@stark.dyndns.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> What binary modules are you running, and what did you use insmod -f on ?

My answer was:

> These modules are loaded. I wasn't running vmware at the time though.

To clarify, and to answer the question you actually asked, None of the modules
loaded were received as binary modules. I compiled them all myself from source
with this kernel's build tree. While the init.d scripts appear to use insmod
-f in fact the modules load just fine with insmod/modprobe without the -f.

-- 
greg

