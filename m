Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264496AbRFTC6H>; Tue, 19 Jun 2001 22:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264567AbRFTC55>; Tue, 19 Jun 2001 22:57:57 -0400
Received: from 513.holly-springs.nc.us ([216.27.31.173]:51213 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S264496AbRFTC5p>; Tue, 19 Jun 2001 22:57:45 -0400
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: linux-kernel@vger.kernel.org
In-Reply-To: <E15CQlA-0006Tr-00@the-village.bc.nu>
In-Reply-To: <E15CQlA-0006Tr-00@the-village.bc.nu>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 19 Jun 2001 22:57:38 -0400
Message-Id: <993005859.1799.1.camel@gromit>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jun 2001 20:01:56 +0100, Alan Cox wrote:

> Linux inherits several unix properties which are not friendly to good state
> based programming - lack of good AIO for one.

Oh, how I would love for select() and poll() to work on files... or for
any other working AIO mothods to be present.

What would get broken if things were changed to let select() work for
filesystem fds?


