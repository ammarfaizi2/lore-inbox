Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbTEQNhO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 09:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTEQNhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 09:37:14 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:58283
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261450AbTEQNhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 09:37:13 -0400
Subject: Re: 2.5.69-mm6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ch@murgatroid.com, Andrew Morton <akpm@digeo.com>
In-Reply-To: <200305162126_MC3-1-3947-176E@compuserve.com>
References: <200305162126_MC3-1-3947-176E@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053175888.7505.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 May 2003 13:51:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-05-17 at 02:23, Chuck Ebbert wrote:
> > All of this stuff should be disablable and far more. It probably all
> > wants hiding under a single "Shrink feature set" type option most people
> > can skip over as they do with kernel debugging.
> 
> 
>   What else should be disablable?

first offhand bits

#! script bin format handling (patch exists for 2.4)
block layer (people using mtd flash dont need it)
swapping

