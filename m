Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262645AbSIPQWt>; Mon, 16 Sep 2002 12:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262626AbSIPQWt>; Mon, 16 Sep 2002 12:22:49 -0400
Received: from ns.suse.de ([213.95.15.193]:13834 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262658AbSIPQWs>;
	Mon, 16 Sep 2002 12:22:48 -0400
Date: Mon, 16 Sep 2002 18:27:45 +0200
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@redhat.com>
Cc: James Cleverdon <jamesclv@us.ibm.com>, linux-kernel@vger.kernel.org,
       James.Bottomley@steeleye.com, torvalds@transmeta.com, mingo@redhat.com
Subject: Re: [PATCH] Summit patch for 2.5.34
Message-ID: <20020916182745.A14132@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@redhat.com>, James Cleverdon <jamesclv@us.ibm.com>,
	linux-kernel@vger.kernel.org, James.Bottomley@steeleye.com,
	torvalds@transmeta.com, mingo@redhat.com
References: <20020916175545.A21875@suse.de> <200209161615.g8GGFqx10004@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200209161615.g8GGFqx10004@devserv.devel.redhat.com>; from alan@redhat.com on Mon, Sep 16, 2002 at 12:15:52PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2002 at 12:15:52PM -0400, Alan Cox wrote:
 > > - I believe the way forward here is to work with James Bottomley,
 > For 2.5 maybe not for 2.4.

Oh, absolutely. subarch support is way too intrusive a change for 2.4.

 > Until Linus takes the subarch stuff the 
 > if if if bits will just get uglier. As well as voyager there are at least
 > two more pending NUMA x86 platforms other than IBM summit

Indeed. And who knows how many more to come...

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
