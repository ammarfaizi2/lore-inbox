Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263353AbTECQtQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 12:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTECQtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 12:49:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:58270
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263353AbTECQtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 12:49:15 -0400
Subject: Re: IBM x440 problems on 2.4.20 to 2.4.20-rc1-ac3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jfv@bluesong.net
Cc: Wojciech Sobczak <Wojciech.Sobczak@comarch.pl>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304301136.24728.jfv@bluesong.net>
References: <01d601c30f17$f3ffadf0$b312840a@nbsobczak>
	 <3270000.1051712524@[10.10.2.4]> <021501c30f27$e02be4a0$b312840a@nbsobczak>
	 <200304301136.24728.jfv@bluesong.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051977775.24563.22.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 May 2003 17:02:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-30 at 19:36, Jack F. Vogel wrote:
> I has nothing to do with gcc, Alan mentioned the magic (or cursed is
> probably the better choice :) word, ACPI. The kernel in SLES 8 has
> the x440 blacklisted so ACPI gets turned off automagically :)

Perhaps someone could submit the x440 blacklist entry to the base kernel
?

