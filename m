Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318733AbSHWJve>; Fri, 23 Aug 2002 05:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318734AbSHWJvd>; Fri, 23 Aug 2002 05:51:33 -0400
Received: from pc-80-195-35-4-ed.blueyonder.co.uk ([80.195.35.4]:54400 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318733AbSHWJvd>; Fri, 23 Aug 2002 05:51:33 -0400
Date: Fri, 23 Aug 2002 10:55:32 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, Stephen Tweedie <sct@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/2] 2.4.20-pre4/ext3: ext3 dirty buffer management
Message-ID: <20020823105532.C2801@redhat.com>
References: <200208222319.g7MNJY509078@sisko.scot.redhat.com> <20020823104744.A12076@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020823104744.A12076@infradead.org>; from hch@infradead.org on Fri, Aug 23, 2002 at 10:47:44AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 23, 2002 at 10:47:44AM +0100, Christoph Hellwig wrote:
> On Fri, Aug 23, 2002 at 12:19:34AM +0100, Stephen Tweedie wrote:

> > This patch set contains the biggest recent change to ext3: a change to
> > the way it deals with other dirty buffers in the system, making it
> > robust against things like dump(8) or tune2fs(8) playing with the block
> > device on a live filesystem.  This patch has been in ext3 CVS for some
> > time now.
 
> No patch attached..

Patch 0/2 was just the description of what's to follow.  I'll label it
"Nopatch 0/2" next time if you want. :)

--Stephen
