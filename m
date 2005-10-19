Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbVJSUKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVJSUKS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 16:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVJSUKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 16:10:17 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:7028 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751295AbVJSUKQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 16:10:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dKC/Shb/yxy0Fp321X5lKJhyl+/3n/PfjC8/xs7n7vEP08Io7hz65nTN9wTDrPHDKdn8lA/Y+1AH/khsIh4JWuj3YeYOdS32r3FtXzvIThT9B/c1yLmS2FGqj3LPj9SK1ta/PzVneqdf8mJJgISxtHbcBhCFtXKobaYOqEPVA20=
Message-ID: <5bdc1c8b0510191310g3fa73535hebe5f45e55875aba@mail.gmail.com>
Date: Wed, 19 Oct 2005 13:10:15 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: -rt10 build problem [WAS]Re: scsi_eh / 1394 bug - -rt7
Cc: Steven Rostedt <rostedt@goodmis.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051019193854.GA12908@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510190750s377a2696kf9c323789b392664@mail.gmail.com>
	 <20051019145435.GA6455@elte.hu>
	 <5bdc1c8b0510190812l6b9574cft14664fa40f1225ce@mail.gmail.com>
	 <20051019193854.GA12908@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/05, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Mark Knecht <markknecht@gmail.com> wrote:
>
> > Sorry. Please resend the patch as a file. My trying to copy it from
> > GMail has apparently killed it:
>
> just pick up -rt11.
>
>         Ingo
>

Thanks Ingo. Sorry for being such a putz! ;-)

2.6.14-rc4-rt11 is up and running. No SCSI errors. No xruns as of yet.

Thanks very much,
Mark
