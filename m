Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbTELVvh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbTELVvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:51:37 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32921
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262783AbTELVvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:51:36 -0400
Subject: Re: The disappearing sys_call_table export.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200305121754_MC3-1-388D-BC60@compuserve.com>
References: <200305121754_MC3-1-388D-BC60@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052773544.31825.16.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 May 2003 22:05:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-12 at 22:51, Chuck Ebbert wrote:
> Alan Cox wrote:
> 
> >>   ...and on a related topic, if someone wrote a patch to optionally clear
> >> the swap area at swapoff would it ever be accepted?
> >
> > man dd ?
> 
>   "That can be done manually" does not get you the check mark in
> the list of features.  Management wants idiot-resistant security.

man dd
man bash

idiot proof != kernel side

And its still a waste of time because you dont have enough guarantees about
things like drive layout.

