Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293245AbSCRX1I>; Mon, 18 Mar 2002 18:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293277AbSCRX06>; Mon, 18 Mar 2002 18:26:58 -0500
Received: from ns.suse.de ([213.95.15.193]:50187 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293245AbSCRX0n>;
	Mon, 18 Mar 2002 18:26:43 -0500
Date: Tue, 19 Mar 2002 00:26:41 +0100
From: Dave Jones <davej@suse.de>
To: Sebastian Droege <sebastian.droege@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.6-dj2] MCE reports 2 non fatal incidents on CPU0 every 2 seconds
Message-ID: <20020319002641.M17410@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Sebastian Droege <sebastian.droege@gmx.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020318193816.44548361.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 07:38:16PM +0100, Sebastian Droege wrote:

 > What exactly is the meaning of these 2 messages?
 > MCE: The hardware reports a non fatal, correctable incident occured on CPU 0.
 > Bank 0: 1000000000000000
 > MCE: The hardware reports a non fatal, correctable incident occured on CPU 0.
 > Bank 4: 2200000000000011
 > 
 > I get them right after boot and every 2 seconds
 > Is my CPU (it's an 3 year-old P-II 350 running 24/7) dying or what's up?

 It may mean I'm having a bad month hacking the mce code, I'll look
 into this later...  Might be the same dumb mistake as last time
 (works on Athlon but Intel behaves differently perhaps)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
