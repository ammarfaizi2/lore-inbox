Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265100AbSJROS7>; Fri, 18 Oct 2002 10:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265101AbSJROS7>; Fri, 18 Oct 2002 10:18:59 -0400
Received: from unthought.net ([212.97.129.24]:11705 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S265100AbSJROS6>;
	Fri, 18 Oct 2002 10:18:58 -0400
Date: Fri, 18 Oct 2002 16:24:59 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021018142459.GJ7875@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <aonbj9$pun$1@abraham.cs.berkeley.edu> <20021017.153627.132905359.davem@redhat.com> <20021017160436.D26442@figure1.int.wirex.com> <20021017.160855.85416723.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021017.160855.85416723.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 04:08:55PM -0700, David S. Miller wrote:
>    From: Chris Wright <chris@wirex.com>
>    Date: Thu, 17 Oct 2002 16:04:36 -0700
>    
>    the photographer would like it if the mp3 player can't remove files
>    in ~/photos/ when it plays a malicious .mp3 file.
>    
> LSM doesn't provide anything in this area which can't be done
> today.  You can protect that directory from malicious programs
> today with file/dir protections and running programs with a different
> capability set or even with a different euid/egid for file accesses.

Ok - now I'm surprised.

How do I prevent my Evolution from reading
Projects/top-secret-stuff/main.c ?

I mean, my emacs should still be able to read it of course, and su'ing
to fifty different users for each of the fifty applications I usually
run is not really an option of course.

Please enlighten me  :)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
