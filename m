Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281061AbRK3WTs>; Fri, 30 Nov 2001 17:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281064AbRK3WTi>; Fri, 30 Nov 2001 17:19:38 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:58619
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281061AbRK3WT0>; Fri, 30 Nov 2001 17:19:26 -0500
Date: Fri, 30 Nov 2001 14:19:20 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Balbir Singh <balbir_soni@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Patch: Fix serial module use count (2.4.16 _and_ 2.5)
Message-ID: <20011130141920.D504@mikef-linux.matchmail.com>
Mail-Followup-To: BALBIR SINGH <balbir.singh@wipro.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011129160637.50471.qmail@web13606.mail.yahoo.com> <20011129161756.D6214@flint.arm.linux.org.uk> <3C070A4D.7000708@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C070A4D.7000708@wipro.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 09:55:49AM +0530, BALBIR SINGH wrote:
> As you say this fix works for 2.4, Since we are into 2.5, I hope
> that it will be fixed in a better manner in 2.5. I have some suggestions,
> ideas for the serial driver in 2.5, are u willing to discuss them?
> 

Would it not be better if the current code in 2.5 had the fix from 2.4 until
the entire layer is audited?
