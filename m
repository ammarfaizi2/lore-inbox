Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132740AbRDQXHK>; Tue, 17 Apr 2001 19:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132829AbRDQXG6>; Tue, 17 Apr 2001 19:06:58 -0400
Received: from mail.gci.com ([205.140.80.57]:39698 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S132740AbRDQXGx>;
	Tue, 17 Apr 2001 19:06:53 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA3150446DA4A@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Manfred Bartz <md-linux-kernel@logi.cc>, linux-kernel@vger.kernel.org
Subject: RE: IP Acounting Idea for 2.5
Date: Tue, 17 Apr 2001 15:06:47 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Bartz writes:
> You are confused.  What would you say if a close() by another,
> unrelated application closed all open descriptors for that file,
> including the one you just opened?  Just fix your applications?

Of course I would fix the application.
And I certainly wouldn't rip the close() out of libc, which is
the tactic that you are suggesting.

Sheesh.



 
