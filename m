Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbUL1Nl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbUL1Nl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 08:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbUL1Nl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 08:41:57 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:45770 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261194AbUL1Nlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 08:41:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=c/ggdtQ6Brtz0IAT94JW9QkH/E+4qB5DfggwwqIqB6Bz6pAv5AgMOxOPXEl19/wU/o9yjxNeMlsdTnhVhskg5V8pR18IobLEqxAe+UHCQsik7VzRuNrAaaJtg+RC/86hNdEX9WfVrZOySF0GuRG554Hr9KLPzmgy6YWXAxpTFM8=
Message-ID: <80d55176041228054116c804c7@mail.gmail.com>
Date: Tue, 28 Dec 2004 08:41:55 -0500
From: Marko Dimiskovski <marko.dimiskovski@gmail.com>
Reply-To: Marko Dimiskovski <marko.dimiskovski@gmail.com>
To: Marko Dimiskovski <marko.dimiskovski@gmail.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: reltime preemption: kernel oops in dri module i810
In-Reply-To: <20041227195839.GA4369@zion.rivenstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <80d5517604122615207069056f@mail.gmail.com>
	 <20041227195839.GA4369@zion.rivenstone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thank you very much.  i hope this bug gets fixed soon because i'm
tired of fooling around with X and i want to record with no problems!
:-)


On Mon, 27 Dec 2004 14:58:39 -0500, Joseph Fannin <jhf@rivenstone.net> wrote:
> On Sun, Dec 26, 2004 at 06:20:45PM -0500, Marko Dimiskovski wrote:
> > got some errors with the i810 and the realtime-preemption patch :-\
> > the kernel version is 2.6.10-rc3-mm1-V0.7.33-04 as you can see from
> > the attached config file and the message file has the oops in it.
> > hope this helps.
> 
>     This is not a problem with the realtime-preemption patch but a bug
> in the i810 drm module in the -mm kernels.  I've been getting this
> too, and have reported it to the dri developers on the dri-devel list.
> 
> --
> Joseph Fannin
> jhf@rivenstone.net
> 
> "Bull in pure form is rare; there is usually some contamination by data."
>     -- William Graves Perry Jr.
> 
> 
>
