Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315335AbSFTRfK>; Thu, 20 Jun 2002 13:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315334AbSFTRfI>; Thu, 20 Jun 2002 13:35:08 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:47633 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S315300AbSFTRfE>;
	Thu, 20 Jun 2002 13:35:04 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Thu, 20 Jun 2002 11:23:15 -0600
To: RW Hawkins <rw@tensilica.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
Message-ID: <20020620112315.I6243@host110.fsmlabs.com>
References: <Pine.LNX.4.44.0206191018510.2053-100000@home.transmeta.com> <m1d6umtxe8.fsf@frodo.biederman.org> <20020620103003.C6243@host110.fsmlabs.com> <3D120DEB.5040304@tensilica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D120DEB.5040304@tensilica.com>; from rw@tensilica.com on Thu, Jun 20, 2002 at 10:16:27AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not disagreeing with Larry here.  I'm just pointing out that mainline
Linux cares about what is commodity.  That's 1-2 processors and 2-4 on
some PPC and other boards.

I'm keenly interested in 1k processors, as is Larry,  and scaling Linux up
to them.  I'm don't disagree with Linus' path for Linux staying on SMP for
now.  Scaling up to huge clusters isn't a mainline Linux concern.  It's a
very interesting research area, though.  In fact, some research I work on.

} You're missing the point. Larry is saying "I have been down this road 
} before, take heed". We don't want to waste the time reinventing bloat 
} when we can learn from others mistakes.
} 
} -RW
} 
}  Cort Dougan wrote:
} 
} >"Beating the SMP horse to death" does make sense for 2 processor SMP
} >machines.  When 64 processor machines become commodity (Linux is a
} >commodity hardware OS) something will have to be done.  When research
} >groups put Linux on 1k processors - it's an experiment.  I don't think they
} >have much right to complain that Linux doesn't scale up to that level -
} >it's not designed to.
} >
} >That being said, large clusters are an interesting research area but it is
} >_not_ a failing of Linux that it doesn't scale to them.
} >-
} >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
} >the body of a message to majordomo@vger.kernel.org
} >More majordomo info at  http://vger.kernel.org/majordomo-info.html
} >Please read the FAQ at  http://www.tux.org/lkml/
} >  
} >
} 
} 
} 
} -
} To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
} the body of a message to majordomo@vger.kernel.org
} More majordomo info at  http://vger.kernel.org/majordomo-info.html
} Please read the FAQ at  http://www.tux.org/lkml/
