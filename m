Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278908AbRJ3Nd2>; Tue, 30 Oct 2001 08:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279794AbRJ3NdS>; Tue, 30 Oct 2001 08:33:18 -0500
Received: from gate.tao-group.com ([62.255.240.131]:48648 "EHLO
	mail.tao-group.com") by vger.kernel.org with ESMTP
	id <S278908AbRJ3NdJ>; Tue, 30 Oct 2001 08:33:09 -0500
Subject: Re: [RFC] 2.4.11-dontuse packages
From: Andrew Ebling <andrew_ebling@tao-group.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011030074542.B5714@pimlott.ne.mediaone.net>
In-Reply-To: <1004445089.485.17.camel@spinel> 
	<20011030074542.B5714@pimlott.ne.mediaone.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.28.14.02 (Preview Release)
Date: 30 Oct 2001 13:33:41 +0000
Message-Id: <1004448821.485.24.camel@spinel>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why don't you just assume that "dontuse" is the standard way to
> indicate a bad kernel, and ask Linus to use that convention in the
> future.  Since you want a way to warn users, this solution meets all
> needs nicely.
> 
> Of course, you have to convince Linus to be consistent in the
> future, but I bet this will be easier than convincing him to change
> something he's already done.  ;-)

Linus, Alan,

Would you be willing to make the "dontuse" suffix a consistent way of
indicating bad kernels in the ftp archives?

I am adding features to the patch-kernel script and would like to use
this as a test to trigger a warning and/or abort.

best regards,

Andrew Ebling

