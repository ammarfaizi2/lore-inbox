Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274744AbRIUCQD>; Thu, 20 Sep 2001 22:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274745AbRIUCPx>; Thu, 20 Sep 2001 22:15:53 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:38795 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S274744AbRIUCPq>; Thu, 20 Sep 2001 22:15:46 -0400
Date: Thu, 20 Sep 2001 22:16:10 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lonely wolf <wolfy@nobugconsulting.ro>, linux-kernel@vger.kernel.org
Subject: Re: probable hardware bug: clock timer configuration lost
Message-ID: <20010920221610.A14451@redhat.com>
In-Reply-To: <3BAA9008.9837EA52@nobugconsulting.ro> <E15kEkB-0006nQ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15kEkB-0006nQ-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Sep 21, 2001 at 02:04:39AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2001 at 02:04:39AM +0100, Alan Cox wrote:
> Its harmless. When we detect this we restore the state of the chip
> correctly. If anything I should kill the printk but I'd still like to 
> figure the precise errata issue out 

Odd, I just got this during booting of my ALi based boards (never had seen 
it before).  Are we certain the test is correct?

		-ben
