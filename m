Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135682AbRDXPro>; Tue, 24 Apr 2001 11:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135687AbRDXPre>; Tue, 24 Apr 2001 11:47:34 -0400
Received: from monza.monza.org ([209.102.105.34]:8966 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S135681AbRDXPrT>;
	Tue, 24 Apr 2001 11:47:19 -0400
Date: Tue, 24 Apr 2001 08:47:07 -0700
From: Tim Wright <timw@splhi.com>
To: Doug Ledford <dledford@redhat.com>
Cc: Eugene Kuznetsov <divx@euro.ru>, linux-kernel@vger.kernel.org
Subject: Re: Problem with i810_audio driver
Message-ID: <20010424084707.B1846@kochanski>
Reply-To: timw@splhi.com
Mail-Followup-To: Doug Ledford <dledford@redhat.com>,
	Eugene Kuznetsov <divx@euro.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <921508308.20010421012021@euro.ru> <3AE4EAEB.254B2A48@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3AE4EAEB.254B2A48@redhat.com>; from dledford@redhat.com on Mon, Apr 23, 2001 at 10:54:35PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 10:54:35PM -0400, Doug Ledford wrote:
[...]
> 
> Both B and C are cases of the whole chip acting flat busted.  I would suspect
> that possibly Win2k drivers set this thing up some way that we don't recover
> from.

Hmmmm...
quite possible. It's certainly true that a soft reboot from win2k leaves the
cs42xx stuff screwed on my Thinkpad T20 so it wouldn't be surprising to hear
of issues with other sound chips. I need to get around to dumping the
registers in the good and bad case to determine what on earth it futzed with
and undo it.

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
