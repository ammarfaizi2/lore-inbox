Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130281AbQKYAsS>; Fri, 24 Nov 2000 19:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130540AbQKYAsK>; Fri, 24 Nov 2000 19:48:10 -0500
Received: from slc807.modem.xmission.com ([166.70.6.45]:31500 "EHLO
        flinx.biederman.org") by vger.kernel.org with ESMTP
        id <S130281AbQKYArw>; Fri, 24 Nov 2000 19:47:52 -0500
To: Peter Samuelson <peter@cadcamlab.org>
Cc: "Matt D. Robinson" <yakker@alacritech.com>,
        64738 <schwung@rumms.uni-mannheim.de>, linux-kernel@vger.kernel.org
Subject: Re: LKCD from SGI
In-Reply-To: <974906422.3a1be4369213b@rumms.uni-mannheim.de> <3A1C0D09.428F5398@alacritech.com> <20001122194145.L2918@wire.cadcamlab.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Nov 2000 16:40:50 -0700
In-Reply-To: Peter Samuelson's message of "Wed, 22 Nov 2000 19:41:45 -0600"
Message-ID: <m1ofz5vszh.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson <peter@cadcamlab.org> writes:

> [Matt D. Robinson]
> > Any way we can standardize 'make install' in the kernel?  It's
> > disturbing to have different install mechanisms per platform ...
> > I can make the changes for a few platforms.
> 
> 2.5 material, already on the todo list.

What is the thought on this.  There is an issue with different
boot loaders needing rather dramatically different formats...

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
