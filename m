Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVGBPl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVGBPl7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 11:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVGBPl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 11:41:59 -0400
Received: from web30507.mail.mud.yahoo.com ([68.142.200.120]:23475 "HELO
	web30507.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261185AbVGBPl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 11:41:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=GfsnzGR5OJJXt5qKNyFpwpHf+IenuKvKEXHk0w2YeYwKPzcExOBRcuBeoC18VkOB5B8Le87a5QUBp6MW/4F/O9wxu0xQI5QeGNC0sAcBjf/dSa31ekIiYhVzSs9HSMXHpO4XYwSPe9UXYmJE8mpJdNYNewRLEbL/CZF/mU4Ymyc=  ;
Message-ID: <20050702154153.88754.qmail@web30507.mail.mud.yahoo.com>
Date: Sat, 2 Jul 2005 08:41:53 -0700 (PDT)
From: Peter Ronnquist <pronnquist@yahoo.com>
Subject: Where/how to start implementing vertical retrace interrupt interface?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If I have understood things correctly then X/x.org can
not provide a flicker free update of the graphics on a
display since the linux kernel does not provide a way
to synchronize to the vertical retrace of a display.

See
http://lists.freedesktop.org/archives/xdg/2004-August/004561.html

If a person with little previous experience of the
linux kernel source tree would like to start on such a
feature then how complicated do you believe it is to
implement? (days or months of work)

Where in the kernel source is a good place to start
looking?

I'm not on the list so please CC me with your reply.

Peter



		
____________________________________________________ 
Yahoo! Sports 
Rekindle the Rivalries. Sign up for Fantasy Football 
http://football.fantasysports.yahoo.com
