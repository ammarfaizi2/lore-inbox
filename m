Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271829AbRIIAhY>; Sat, 8 Sep 2001 20:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271831AbRIIAhO>; Sat, 8 Sep 2001 20:37:14 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:53264 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S271829AbRIIAhE>; Sat, 8 Sep 2001 20:37:04 -0400
Date: Sun, 9 Sep 2001 02:37:22 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010909023722.A1482@emma1.emma.line.org>
Mail-Followup-To: Kai Henningsen <kaih@khms.westfalen.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <oupg0a1wi9x.fsf@pigdrop.muc.suse.de> <20010905152738.C5912BC06D@spike.porcupine.org.suse.lists.linux.kernel> <20010905182033.D3926@emma1.emma.line.org.suse.lists.linux.kernel> <oupg0a1wi9x.fsf@pigdrop.muc.suse.de> <20010906151113.A29583@ma <88VMRprXw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <88VMRprXw-B@khms.westfalen.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Henningsen schrieb am Samstag, den 08. September 2001:

[old Postfix versions consider network classes]
> The WHAT?!
> 
> Classes have been dead since around 1993!

In case you missed that from the paragraph below that you quoted,
Postfix tries to look up the netmasks from the interfaces nowadays - and
stumbles across incompatibilities that are the reason for this thread.
You can always manually override this configuration.

> > but there have been many complaints by people that this would
> > get subnets wrong. A couple of months ago, Postfix has started to look
> > up the netmasks as well.

-- 
Matthias Andree
Outlook (Express) users: press Ctrl+F3 for the full source code of this post.
begin  dont_click_this_virus.exe
end
