Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVFJMdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVFJMdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 08:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVFJMdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 08:33:20 -0400
Received: from hazard.jcu.cz ([160.217.1.6]:23976 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id S261557AbVFJMdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 08:33:16 -0400
Date: Fri, 10 Jun 2005 14:33:16 +0200
From: Jan Marek <linux@hazard.jcu.cz>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: Mark Haverkamp <markh@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Adaptec RAID 2010S hang-up under heavy load
Message-ID: <20050610123315.GB28099@hazard.jcu.cz>
References: <60807403EABEB443939A5A7AA8A7458B0147C0D5@otce2k01.adaptec.com> <20050610122638.GA28099@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610122638.GA28099@hazard.jcu.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello once more,

On Fri, Jun 10, 2005 at 02:26:38PM +0200, Jan Marek wrote:
> Hello Mark,
> 
> On Thu, Jun 09, 2005 at 01:51:44PM -0400, Salyzyn, Mark wrote:
> > The 2010S uses the dpt_i2o driver. You must be using a different aacraid
> > based card. I can not determine which aacraid based card you are using
> > from the logs. The 2120S perhaps? The 2120S is the single channel cousin
> > of the 2200S and MarkH's advise should be taken (update to latest
> > Firmware).
> 
> I'm very sorry about that: it's really 2200S. And it has firmware 6011
> from asr2200s_fw_up_b6011.exe. Is somewhere a newest one?

I'm sorry, I have found firmware 7349. I will try it.

Thank you very much.

> 
> > 
> > Sincerely -- Mark Salyzyn
> 
> Sincerely
> Jan Marek

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080
