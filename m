Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262538AbSJLA7J>; Fri, 11 Oct 2002 20:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262576AbSJLA7J>; Fri, 11 Oct 2002 20:59:09 -0400
Received: from smtp09.iddeo.es ([62.81.186.19]:59275 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S262538AbSJLA7I>;
	Fri, 11 Oct 2002 20:59:08 -0400
Date: Sat, 12 Oct 2002 03:04:55 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre10aa1
Message-ID: <20021012010455.GA1647@werewolf.able.es>
References: <20021010230945.GB1251@dualathlon.random> <20021011222830.GA1645@werewolf.able.es> <20021011224237.GQ24468@dualathlon.random> <20021011225228.GE1645@werewolf.able.es> <20021011232539.GR24468@dualathlon.random> <20021012003642.GG2704@werewolf.able.es> <20021012004309.GI2704@werewolf.able.es> <20021012004827.GA34193@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021012004827.GA34193@compsoc.man.ac.uk>; from levon@movementarian.org on Sat, Oct 12, 2002 at 02:48:27 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.12 John Levon wrote:
>On Sat, Oct 12, 2002 at 02:43:09AM +0200, J.A. Magallon wrote:
>
>> struct t_t;
>> 
>> to
>> 
>> typdef struct t_t t_t;
>
>Now wonder what the point of a typedef is when you have to expose the
>underlying type anyway ;)
>

Do not wonder of anything, it is just a hack people uses to avoid
spliting all kernel headers in public and private parts, ala X.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-pre10-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
