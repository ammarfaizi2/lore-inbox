Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTDSL5D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 07:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTDSL5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 07:57:03 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:43781 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S263380AbTDSL5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 07:57:02 -0400
Date: Sat, 19 Apr 2003 22:08:41 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Muli Ben-Yehuda <mulix@mulix.org>
cc: Andy Chou <acc@CS.Stanford.EDU>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 6 memory leaks
In-Reply-To: <20030419094445.GA7283@actcom.co.il>
Message-ID: <Mutt.LNX.4.44.0304192206470.31750-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Apr 2003, Muli Ben-Yehuda wrote:

> This one appears to be exactly the same as the previous one, except
> the line number is different. Does that mean the checker things there
> are two leaks in this piece of code? 

This one was for the ipv6 version.  If you could make a patch for ipv6, 
I'll forward both to Dave Miller.


Thanks,


- James
-- 
James Morris
<jmorris@intercode.com.au>


