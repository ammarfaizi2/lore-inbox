Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312495AbSDKRJP>; Thu, 11 Apr 2002 13:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312526AbSDKRJO>; Thu, 11 Apr 2002 13:09:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31761 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312495AbSDKRJM>;
	Thu, 11 Apr 2002 13:09:12 -0400
Date: Thu, 11 Apr 2002 18:09:10 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux as a minicomputer ?
Message-ID: <20020411170910.GS612@gallifrey>
In-Reply-To: <20020411154601.GY17962@antefacto.com> <20020411164331.GR612@gallifrey> <20020411184923.A15238@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 18:08:18 up 5 days, 21:44,  5 users,  load average: 2.04, 2.05, 2.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Vojtech Pavlik (vojtech@suse.cz) wrote:
> 
> Doesn't work unfortunately. The separate Xservers stomp on each others
> toes in the process. It works if you use fbcon (thus no acceleration, no
> 3d), USB, and hack the X servers not to switch consoles, and take
> keyboard input from /dev/input/event devices. But that's still far from
> the desired state of things.
> 

Oh how annoying - where do they get knotted up? I'd presumed this was
the whole point of the busid spec in the config file.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
