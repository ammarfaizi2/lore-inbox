Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbTAJMmu>; Fri, 10 Jan 2003 07:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264954AbTAJMmu>; Fri, 10 Jan 2003 07:42:50 -0500
Received: from hermes.domdv.de ([193.102.202.1]:54538 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S264756AbTAJMmt>;
	Fri, 10 Jan 2003 07:42:49 -0500
Message-ID: <3E1EC1D1.1030000@domdv.de>
Date: Fri, 10 Jan 2003 13:51:29 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en, de-de, de
MIME-Version: 1.0
To: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Severe reiserfs problems
References: <200301101332.50873.robert.szentmihalyi@entracom.de>
In-Reply-To: <200301101332.50873.robert.szentmihalyi@entracom.de>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Szentmihalyi wrote:
> Hi,
>  
> I have severe file system problems on a reiserfs partition.
> When I try copy files to another filesystem, the kernel panics at certain 
> files.
> 
> reiserfsck --fix-fixable says that I need to run 
> reiserfsck --rebuild-tree to fix the errors, but when I do this,
> reiserfsck hangs after a few secounds.
> Is there a way to rescue at least some of the data on the partition?
> 
> Any help is highly appreciated.
> 
> TIA,
>  Robert
> 
> 
I had a behaviour somewhat like this once which turned out to be defunct 
memory. Though I can't help you with data recovery I would advise you to 
run memtest86.

-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

