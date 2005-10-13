Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVJMRw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVJMRw7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 13:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVJMRw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 13:52:59 -0400
Received: from [67.137.28.189] ([67.137.28.189]:19329 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S932136AbVJMRw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 13:52:59 -0400
Message-ID: <434E8BED.5050506@utah-nac.org>
Date: Thu, 13 Oct 2005 10:31:41 -0600
From: "Jeff V. Merkey" <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.31] Reintroduction i386 CONFIG_DUMMY_KEYB option
References: <200510131838.45082.nick@linicks.net>
In-Reply-To: <200510131838.45082.nick@linicks.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Warne wrote:

>Hi all,
>
>A small patch here to reintroduce the dummy keyboard, which seems to have been 
>lost sometime - refer to my LKML thread:
>
>http://marc.theaimsgroup.com/?l=linux-kernel&m=112885471602308&w=2
>
>
>
>  
>
A serial based keyboard driver for general purpose debuggers and test 
harnesses would be a whole lot more useful.  Ever consider it?  Snatch 
the one out of kdb and submit it as a patch.  The AIMS test.  I remember 
that from my Memorex Telex days on OS/2.

Jeff
