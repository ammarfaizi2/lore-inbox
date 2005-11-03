Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030427AbVKCSuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbVKCSuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbVKCSuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:50:20 -0500
Received: from wirelesslogix.com ([209.18.121.242]:61964 "EHLO
	mailrelay.wirelesslogixgroup.com") by vger.kernel.org with ESMTP
	id S1030427AbVKCSuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:50:19 -0500
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [stable] Re: 4GB memory and Intel Dual-Core system
Date: Thu, 3 Nov 2005 19:34:08 +0100
User-Agent: KMail/1.8
Cc: Chris Wright <chrisw@osdl.org>, Dave Jones <davej@redhat.com>,
       Marcel Holtmann <marcel@holtmann.org>,
       Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org,
       Shaohua Li <shaohua.li@intel.com>, torvalds@osdl.org, stable@kernel.org
References: <20051028205833.GM2533@mail.muni.cz> <20051030064938.GA24429@redhat.com> <20051031210458.GS5856@shell0.pdx.osdl.net>
In-Reply-To: <20051031210458.GS5856@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511031934.08938.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 22:04, Chris Wright wrote:
> * Dave Jones (davej@redhat.com) wrote:
> > The following patch Andi forwarded never actually made it into 2.6.14.
> > Definite 2.6.14.1 material IMO.
>
> Thanks, queued to -stable.  Also, this one is still not upstream.

Will be soon, but in general I would prefer if you didn't merge anything
into STABLE that wasn't upstream yet. Otherwise we risk code drift again.

Thanks,
-Andi
