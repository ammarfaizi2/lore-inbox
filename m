Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263197AbSJFA4t>; Sat, 5 Oct 2002 20:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263225AbSJFA4q>; Sat, 5 Oct 2002 20:56:46 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:43668
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263197AbSJFA4o>; Sat, 5 Oct 2002 20:56:44 -0400
Date: Sat, 5 Oct 2002 21:00:06 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Gigi Duru <giduru@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: The end of embedded Linux?
In-Reply-To: <20021006005048.GH10722@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0210052056210.20917-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2002, William Lee Irwin III wrote:

> I actually find this relatively disturbing:
> 
> Memory: 2584k/4352k available (881k kernel code, 1380k reserved, 171k data, 56k
> init, 0k hi)
> 
> To truly scale this far downward finding ways to use less than 40% of
> RAM on things allocated at or before boot-time seems necessary,
> especially trimming down that 881KB.
> 
> I'll have to apologize that it's unlikely I'll be able to take any
> direct action toward addressing this problem as my focus is elsewhere,
> but I consider this a valid and even important concern.

Indeed, the box in question didn't require any more memory for its 
application so that somewhat bloated kernel was sufficient. I could have 
saved a bit more by removing a lot of drivers, e.g. IDE

	Zwane

-- 
function.linuxpower.ca

