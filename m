Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265969AbUBPXWL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266049AbUBPXWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:22:11 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:16544 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265969AbUBPXWH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 18:22:07 -0500
Subject: Re: Kernel Highmemory problem
From: Dave Hansen <haveblue@us.ibm.com>
To: Shesha Sreenivasamurthy <shesha@inostor.com>
Cc: "'redhat-ppp-list@redhat.com'" <redhat-ppp-list@redhat.com>,
       "'kernelnewbies@nl.linux.org'" <kernelnewbies@nl.linux.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <402FFA91.5020206@inostor.com>
References: <01C3E716.AA1B04A0.vanitha@agilis.st.com.sg>
	 <402FFA91.5020206@inostor.com>
Content-Type: text/plain
Message-Id: <1076973693.10966.39.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 15:21:33 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-15 at 15:02, Shesha Sreenivasamurthy wrote:
> Hi All,
> I have a driver that currently does not support highmem. i.e., no "kmap" 
> & "kunmap" is being implemented. Now we want to support more than 896MB 
> RAM. What is the best approach to tackle the situation? Any ideas is 
> highly valued.

Which driver are you referring to?  Posting a copy of it would be a good
first step, so we can get an idea what we're dealing with.

--dave

