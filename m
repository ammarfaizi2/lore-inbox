Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312147AbSCRAFp>; Sun, 17 Mar 2002 19:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312148AbSCRAFf>; Sun, 17 Mar 2002 19:05:35 -0500
Received: from zeus.kernel.org ([204.152.189.113]:7084 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S312147AbSCRAF3>;
	Sun, 17 Mar 2002 19:05:29 -0500
Date: Sun, 17 Mar 2002 16:01:36 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Matthew D. Pitts" <mpitts@suite224.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre3-ac1
Message-ID: <20020318000136.GC27249@matchmail.com>
Mail-Followup-To: "Matthew D. Pitts" <mpitts@suite224.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020316190415.38CE14E534@mail.vnsecurity.net> <E16mLFj-000794-00@the-village.bc.nu> <20020317053624.GD23938@matchmail.com> <003901c1ce0e$e5c15040$b0d3fea9@pcs686>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003901c1ce0e$e5c15040$b0d3fea9@pcs686>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 06:52:51PM -0500, Matthew D. Pitts wrote:
> L-K developers,
> 
> What is the recomended amount of swap if you have a PC with 384 MB ram?

There is not a single right answer because it's based on your work load.

I would set it to 2x or 3x the ammount of swap you currently have *in use* during
normal operation.

For smaller ammounts of ram (measured in the hundreds) I'd just make it
equal to how much ram you have.  With more ram, use the above suggestion.

Mike
