Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312563AbSDKROS>; Thu, 11 Apr 2002 13:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312576AbSDKROR>; Thu, 11 Apr 2002 13:14:17 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:36543 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S312563AbSDKROO>;
	Thu, 11 Apr 2002 13:14:14 -0400
Date: Thu, 11 Apr 2002 19:13:39 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: linux as a minicomputer ?
Message-ID: <20020411191339.B15435@ucw.cz>
In-Reply-To: <20020411154601.GY17962@antefacto.com> <20020411164331.GR612@gallifrey> <20020411184923.A15238@ucw.cz> <20020411170910.GS612@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 06:09:10PM +0100, Dr. David Alan Gilbert wrote:

> > Doesn't work unfortunately. The separate Xservers stomp on each others
> > toes in the process. It works if you use fbcon (thus no acceleration, no
> > 3d), USB, and hack the X servers not to switch consoles, and take
> > keyboard input from /dev/input/event devices. But that's still far from
> > the desired state of things.
> > 
> 
> Oh how annoying - where do they get knotted up?

See my other mail.

> I'd presumed this was
> the whole point of the busid spec in the config file.

No, it's for running one Xserver on multiple displays at once only.

Sad, ain't it?

-- 
Vojtech Pavlik
SuSE Labs
