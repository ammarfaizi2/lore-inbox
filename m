Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262052AbREQQ6E>; Thu, 17 May 2001 12:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262057AbREQQ5o>; Thu, 17 May 2001 12:57:44 -0400
Received: from mailproxy.de.uu.net ([192.76.144.34]:41404 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S262055AbREQQ5c>; Thu, 17 May 2001 12:57:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: t.sailer@alumni.ethz.ch
Subject: Re: LANANA: To Pending Device Number Registrants
Date: Thu, 17 May 2001 18:58:09 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <E150AgG-0004bb-00@the-village.bc.nu> <3B030DDE.B4E7B0CC@transmeta.com> <3B037304.1643693A@scs.ch>
In-Reply-To: <3B037304.1643693A@scs.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01051718580902.00784@cookie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 May 2001 08:43, Thomas Sailer wrote:
> Cheap USB devices (and sometimes even expensive ones)
> do not have serial numbers or other unique identifiers.
> Therefore some sort of topology based addressing scheme
> has to be used in that case.

No, there is another addressing scheme that can be for devices without serial 
number: the vendor and product ids. Most people do not have two devices of 
the same kind, so you often do not need the topology at all.

BTW this document describes the use of device ids on windows:
http://www.osr.com/ddk/idstrings_8tt3.htm

bye...
