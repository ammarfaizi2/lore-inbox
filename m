Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbSJ3WBD>; Wed, 30 Oct 2002 17:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264922AbSJ3WBD>; Wed, 30 Oct 2002 17:01:03 -0500
Received: from 205-158-62-132.outblaze.com ([205.158.62.132]:16794 "HELO
	ws5-2.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S264920AbSJ3WBC>; Wed, 30 Oct 2002 17:01:02 -0500
Message-ID: <20021030220721.672.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: akpm@digeo.com, arashi@arashi.yi.org
Cc: linux-kernel@vger.kernel.org
Date: Thu, 31 Oct 2002 06:07:21 +0800
Subject: Re: poll-related
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@digeo.com>
> Paolo Ciarrocchi wrote:
> > 
> > >> So my guess is somewhere between -mm5 and -mm6 we
> > >> screwed up the atomicity count.
> > >Mine too.  I'll check it out, thanks.
> > 
> > The same here as well
> > 
> 
> This'll fix it up.  Whoever invented cut-n-paste has a lot to
> answer for.

Applied, compiled, installed, stressed.
Everything is _OK_

Thank you Andrew!

Paolo

-- 

Powered by Outblaze
