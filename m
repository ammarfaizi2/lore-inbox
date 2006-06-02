Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWFBGR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWFBGR6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 02:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWFBGR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 02:17:58 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:38436 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751201AbWFBGR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 02:17:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WW7FmABMJagJNYBWJPM2S8oAviedGIuU+ujnU6y9x74LCiexuWN/oY7jq08abU96FUpHtfARB9zuYNLajF0BdHuLjCpT6FXa1Qbf7C0V7BezB7Ktuv19Vl2mKx2yWOtuZuAoDvOBXE1AJnOyUY9j1C2VplMb5z70waJ+vV2Cye8=
Message-ID: <20f65d530606012317u7d49f476w4bfaa5b6cc08e94e@mail.gmail.com>
Date: Fri, 2 Jun 2006 18:17:56 +1200
From: "Keith Chew" <keith.chew@gmail.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Subject: Re: IRQ sharing: BUG: spinlock lockup on CPU#0
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200606020137_MC3-1-C164-9068@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606020137_MC3-1-C164-9068@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuck

>
> Your mailer is garbling long lines when it wraps them...
>

Oh dear, it looks like we forgot to set Line Wrapping in minicom, that
was real silly. Will post another stack trace as soon as another feeze
happens.

Regards
Keith
