Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262887AbVAFPdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbVAFPdp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbVAFPcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:32:50 -0500
Received: from [213.146.154.40] ([213.146.154.40]:3752 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262861AbVAFPbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:31:53 -0500
Date: Thu, 6 Jan 2005 15:31:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andi Kleen <ak@suse.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
       mingo@elte.hu, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com, greg@kroah.com,
       VANDROVE@vc.cvut.cz
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Message-ID: <20050106153147.GB19324@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lee Revell <rlrevell@joe-job.com>, Andi Kleen <ak@suse.de>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>,
	Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
	mingo@elte.hu, linux-kernel@vger.kernel.org, pavel@suse.cz,
	discuss@x86-64.org, gordon.jin@intel.com, greg@kroah.com,
	VANDROVE@vc.cvut.cz
References: <20041217014345.GA11926@mellanox.co.il> <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050106145356.GA18725@infradead.org> <20050106150941.GE1830@wotan.suse.de> <20050106151429.GA19155@infradead.org> <1105024942.13396.4.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <1105024942.13396.4.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 06, 2005 at 10:22:21AM -0500, Lee Revell wrote:
> > p.s. droppe alsa-devel from Cc because of the braindead moderation policy.
> > 
> 
> Um, alsa-devel is not moderated, we accept posts from non subscribers.
> Where do you think all the spam in our archive comes from?

See the attached mail I got.  Btw, where are the current alsa-devel
archives?  I tried to look things up a few times lately, but all archives
linked off the websiste are either dead or totally outdated.


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=alsa-mod

>From alsa-devel-admin@lists.sourceforge.net Thu Jan 06 14:56:18 2005
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Envelope-to: hch@infradead.org
Delivery-date: Thu, 06 Jan 2005 14:56:18 +0000
Received: from mx-outbound.sourceforge.net ([66.35.250.223])
	by pentafluge.infradead.org with esmtp (Exim 4.42 #1 (Red Hat Linux))
	id 1CmZ3h-0004tZ-A6
	for hch@infradead.org; Thu, 06 Jan 2005 14:56:18 +0000
Received: from projects.sourceforge.net (sc8-sf-list2-b.sourceforge.net [10.3.1.8])
	by sc8-sf-spam1.sourceforge.net (Postfix) with ESMTP id 553EB88F8E
	for <hch@infradead.org>; Thu,  6 Jan 2005 06:56:06 -0800 (PST)
Date: Thu, 06 Jan 2005 06:56:06 -0800
Subject: Your message to Alsa-devel awaits moderator approval
From: alsa-devel-admin@lists.sourceforge.net
To: hch@infradead.org
X-Ack: no
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
X-BeenThere: alsa-devel@lists.sourceforge.net
X-Mailman-Version: 2.0.9-sf.net
Precedence: bulk
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: Advanced Linux Sound Architecture - Devel <alsa-devel.lists.sourceforge.net>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Message-Id: <20050106145606.553EB88F8E@sc8-sf-spam1.sourceforge.net>
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 NO_REAL_NAME           From: does not include a real name
Status: RO
Content-Length: 351
Lines: 12

Your mail to 'Alsa-devel' with the subject

    Re: [PATCH] deprecate (un)register_ioctl32_conversion

Is being held until the list moderator can review it for approval.

The reason it is being held:

    Too many recipients to the message

Either the message will get posted to the list, or you will receive
notification of the moderator's decision.


--d6Gm4EdcadzBjdND--
