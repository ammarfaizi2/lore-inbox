Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263704AbTCVQGt>; Sat, 22 Mar 2003 11:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263707AbTCVQGt>; Sat, 22 Mar 2003 11:06:49 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:43162
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263704AbTCVQGt>; Sat, 22 Mar 2003 11:06:49 -0500
Subject: Re: lmbench results for 2.4 and 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E7C8B22.7020505@nortelnetworks.com>
References: <3E7C8B22.7020505@nortelnetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048354194.9221.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2003 17:29:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-22 at 16:11, Chris Friesen wrote:
> My previous testing with unix sockets prompted me to do a few lmbench runs with 
> 2.4.19 and 2.5.65.  The results have me a bit concerned, as there is no area 
> where 2.5 is faster and several where it is significantly slower.

Are you building both with SMP off, and pre-empt off ? Also both with APM/ACPI off ?

