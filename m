Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131307AbRD2Th1>; Sun, 29 Apr 2001 15:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131407AbRD2ThQ>; Sun, 29 Apr 2001 15:37:16 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:52509 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S131307AbRD2ThD>; Sun, 29 Apr 2001 15:37:03 -0400
Date: Sun, 29 Apr 2001 22:36:41 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Cc: duncan@gauldd.freeserve.co.uk
Subject: Re: question regarding cpu selection
Message-ID: <20010429223641.K3529@niksula.cs.hut.fi>
In-Reply-To: <01042919075101.01335@pc-62-31-91-135-dn.blueyonder.co.uk> <20010429145608.A703@better.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010429145608.A703@better.net>; from parkw@better.net on Sun, Apr 29, 2001 at 02:56:08PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 02:56:08PM -0400, you [William Park] claimed:
> On Sun, Apr 29, 2001 at 07:07:51PM -0400, Duncan Gauld wrote:
> > Hi,
> > This seems a silly question but - I have an intel celeron 800mhz CPU and thus 
> > it is of the Coppermine breed. But under cpu selection when configuring the 
> > kernel, should I select PIII or PII/Celeron? Just wondering, since Coppermine 
> > is basically a newish PIII with 128K less cache...
> 
> Try both, and see if your machine throws up.

800Mhz Celeron is actually a CeleronII, and it does SSE just like PIII (the
only difference being cache). Therefore PIII option should work.

Perhaps this should be fixed in the config menu (or is it already? Which
kernel are you compiling?)


-- v --

v@iki.fi
