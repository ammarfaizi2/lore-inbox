Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUAKXAR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 18:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266008AbUAKXAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 18:00:17 -0500
Received: from mta13.mail.adelphia.net ([68.168.78.44]:40881 "EHLO
	mta13.adelphia.net") by vger.kernel.org with ESMTP id S266006AbUAKXAO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 18:00:14 -0500
Subject: Re: PCMCIA lockups on HP Pavilion laptop
From: Aubin LaBrosse <arl8778@rit.edu>
To: Peter Lieverdink <peter@cc.com.au>
Cc: linux-kernel@vger.kernel.org, rmk+lkml@arm.linux.org.uk,
       maverick@eskuel.net
In-Reply-To: <1073860473.1103.3.camel@kahlua>
References: <1073191980.1505.32.camel@localhost.localdomain>
	 <1073860473.1103.3.camel@kahlua>
Content-Type: text/plain
Message-Id: <1073862011.9478.11.camel@rain.rh.rit.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 11 Jan 2004 18:00:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-11 at 17:34, Peter Lieverdink wrote:

> 
> http://www.consultmatt.co.uk/nx9005/config.php
> 
> - Peter.

I'll keep that one in mind as well, thanks Peter.  Mathieu's reply
(earlier in this thread) fixed it for me, i used the config he put in
his mail.  thanks to all of you for your help and insight!

Russell, would it be useful to you if I tracked it down more precisely
anyway? the config mathieu posted worked for me so i didn't look too
deep, but if you'd like me to try and narrow it down so that we know
which io space causes problems on these machines i could do that. 

-aubin

