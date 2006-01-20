Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWATQko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWATQko (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWATQko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:40:44 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:21910 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751077AbWATQkn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:40:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KmnixOx2Vhw9P2/8OrQqsI2SdJsQr9SPDtPYUBtuJ6HvnInVLdGaMCLAfdTSf/vflRtb0GgGtj6q+FqLB9UQwee7M4vdLop8BNdn5uL4/9JNNrGu3L8ntIis1P2JTg6xWMfndrx/Pso/ylGsEZhnUVfjAhSrMdbmqeAy8sAwCDQ=
Message-ID: <d120d5000601200840o704af2e5h6d9087b62594bbe1@mail.gmail.com>
Date: Fri, 20 Jan 2006 11:40:42 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Marc Koschewski <marc@osknowledge.org>
Subject: Re: Development tree, PLEASE?
Cc: Michael Loftis <mloftis@wgops.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060120155919.GA5873@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
	 <20060120155919.GA5873@stiffy.osknowledge.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/06, Marc Koschewski <marc@osknowledge.org> wrote:
>
> For my daily work I use the -git kernels on my production machines. And I didn't
> have probs for a long time due to stuff being tested in -mm. -mm is mostly
> broken for me (psmouse, now reiserfs, ...) but I tend to say that 2.6 is
> rock-stable.
>

[Trying to steal the thread somewhat...]

Marc, have you tried 2.6.16-rc1 yet? Does it also give you problems
with psmouse?

--
Dmitry
