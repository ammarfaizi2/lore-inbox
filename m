Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310223AbSCFWl2>; Wed, 6 Mar 2002 17:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310227AbSCFWlS>; Wed, 6 Mar 2002 17:41:18 -0500
Received: from www.transvirtual.com ([206.14.214.140]:14343 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S310223AbSCFWlB>; Wed, 6 Mar 2002 17:41:01 -0500
Date: Wed, 6 Mar 2002 14:40:42 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Paul Mundt <lethal@chaoticdreams.org>
cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  March 6, 2002
In-Reply-To: <20020306124100.A18620@ChaoticDreams.ORG>
Message-ID: <Pine.LNX.4.10.10203061439320.12924-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002, Paul Mundt wrote:

> On Wed, Mar 06, 2002 at 12:07:14PM -0800, James Simmons wrote:
> > As for the framebuffer stuff that can also be synced for the most part.
> > At present I'm working on new soft accels to replace that fbcon-cfb* mess.
> > The one thing missing is a universal cursor api. I purposed one but
> > nothing happened. Its not urgent yet anyways.
> > 
> If this stuff is being cleaned up, I still have a large chunk of fixes locally
> in my tree that need to be pushed up to linuxconsole CVS. Is the linuxconsole
> stuff going to be synced up all at once, or is still going to be progressive?
> If it's progressive, I'd still like to get my stuff cleaned up before pushing
> it into CVS..

It will be progressive. Just watch out for the recent updates in CVS.


   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/


