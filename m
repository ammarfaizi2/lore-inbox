Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264415AbTL0Mn0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 07:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264423AbTL0MnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 07:43:25 -0500
Received: from ip3e83a512.speed.planet.nl ([62.131.165.18]:54823 "EHLO
	made0120.speed.planet.nl") by vger.kernel.org with ESMTP
	id S264415AbTL0MnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 07:43:24 -0500
Message-ID: <3FED7E80.20800@planet.nl>
Date: Sat, 27 Dec 2003 13:43:44 +0100
From: Stef van der Made <svdmade@planet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: wrlk@riede.org, linux-kernel@vger.kernel.org
Subject: Re: The survival of ide-scsi in 2.6.x
References: <20031226181242.GE1277@linnie.riede.org>
In-Reply-To: <20031226181242.GE1277@linnie.riede.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willem Riede wrote:

snip

>(By the way, ide-tape contains code for the ATAPI version, the 
>DI-30, but that code is old and has serveral known problems - 
>I'd like to see it removed - or at least deprecated - I will do 
>that myself later if people want me to.)
>
>  
>
snip

After some fixing on ide-scsi my DI-30 is now working fine. I don't know 
of any bugs in it. All works fine for me. Getting rid if ide-scsi might 
be a good idea but it ain't going to be easy as a lot of programs are 
using the code.

 If you need a tester for the di-30 please feed me the patches and I'll 
play around with them.

Cheers,

Stef
