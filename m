Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263022AbVBCPTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263022AbVBCPTY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 10:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbVBCPTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 10:19:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26757 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263860AbVBCPSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 10:18:07 -0500
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Peter Osterlund <petero2@telia.com>,
       linux-kernel@vger.kernel.org, dtor_core@ameritech.net
Subject: Re: Touchpad problems with 2.6.11-rc2
References: <20050123190109.3d082021@localhost.localdomain>
	<m3acqr895h.fsf@telia.com>
	<20050201234148.4d5eac55@localhost.localdomain>
	<20050202102033.GA2420@ucw.cz>
	<20050202085628.49f809a0@localhost.localdomain>
	<20050202170727.GA2731@ucw.cz>
	<20050202095851.27321bcf@localhost.localdomain>
	<or4qgurqp5.fsf@livre.redhat.lsd.ic.unicamp.br>
	<20050203084900.GA2594@ucw.cz>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 03 Feb 2005 13:17:53 -0200
In-Reply-To: <20050203084900.GA2594@ucw.cz>
Message-ID: <orwttpad0e.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb  3, 2005, Vojtech Pavlik <vojtech@suse.cz> wrote:

> On Thu, Feb 03, 2005 at 06:30:14AM -0200, Alexandre Oliva wrote:
>> On Feb  2, 2005, Pete Zaitcev <zaitcev@redhat.com> wrote:
>> 
>> > On Wed, 2 Feb 2005 18:07:27 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
>> 
>> >> With a Synaptics I suppose? You wouldn't like it with an ALPS.
>> 
>> > No, it's a Dualpoint, and so ALPS.
>> 
>> Err...  That doesn't follow.  My Dell Inspiron 8000 has a Synaptics
>> touchpad as part of the Dualpoint pointing devices.
 
> Dualpoint (tm) is a trademark of ALPS,

Interesting...  Dell DualPoint is the way the pointing devices are
described in that notebook's documentation, and I remember all the way
from back when I purchased the notebook: I really wanted the two
pointing devices.  If you search the web for Dell Inspiron 8000
DualPoint, you'll get a number of hits referring to `Dell's DualPoint
technology'.  I don't see them referred to as DualPoint(TM), but I
vaguely remember having seen something like that in Dell's web site
back then.

Maybe ALPS bought the trademark from Dell, or Dell hadn't actually
registered the trademark, or they somehow managed to get the
trademarks registered with a case difference (DualPoint vs Dualpoint)?

> so in your case you have both a touchpoint and a touchpad, but it's
> not called a Dualpoint in this case, because it's two separate
> devices.

Indeed, it's called Dell DualPoint.  Sorry about the confusion.  Not
really my fault, I think :-) :-)

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
