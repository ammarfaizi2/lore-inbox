Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271779AbRICSp7>; Mon, 3 Sep 2001 14:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271777AbRICSpt>; Mon, 3 Sep 2001 14:45:49 -0400
Received: from dsl-212-135-211-72.dsl.easynet.co.uk ([212.135.211.72]:57349
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S271779AbRICSpn>; Mon, 3 Sep 2001 14:45:43 -0400
Message-ID: <3B93CF91.A6D59DA8@haywired.org>
Date: Mon, 03 Sep 2001 19:44:33 +0100
From: Simon Hay <simon@haywired.org>
X-Mailer: Mozilla 4.61 [en] (OS/2; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Multiple monitors
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Apologies in advance if this is a question that's already been answered
somewhere...  I'm looking for a way to install multiple (or rather, two)
PCI/AGP cards in a machine and connect a monitor to each one, and use
them both *in console mode* - preferably with some nice way to say
'assign virtual console 2 to the first screen, and 5 to the second' -
that way you could have one tailing log files, showing 'top', whatever. 
A quick search of the web/newsgroups turned up various patches that
looked ideal, but a closer inspection revealed that they either relied
on you having a Hercules mono card, or only applied against kernel
<0.99, or both...  I was just wondering if anyone's thought
about/written a similar patch for more recent hardware/versions?  I was
using a console Linux machine running BB (ASCII art demo -
http://aa-project.sourceforge.net/) just to attract attention to our
stand today and was thinking it would be really neat to have one machine
driving several screens...

Simon
