Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030785AbWJDJtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030785AbWJDJtO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 05:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030786AbWJDJtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 05:49:14 -0400
Received: from mx10.go2.pl ([193.17.41.74]:43186 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1030785AbWJDJtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 05:49:14 -0400
Date: Wed, 4 Oct 2006 11:53:47 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: Willy Tarreau <w@1wt.eu>
Cc: Keith Mannthey <kmannth@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: System hang problem.
Message-ID: <20061004095347.GA7462@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>, Willy Tarreau <w@1wt.eu>,
	Keith Mannthey <kmannth@gmail.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004032656.GB5050@1wt.eu>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-10-2006 05:26, Willy Tarreau wrote:
...
> To better understand how the overcommit works, imagine that you have
> several people who need to put eggs in the same box. By default, they
> are blind and simply put their eggs there. But they don't see if the
> box is overloaded or not. So once the box is full and they push new
> eggs, they start to break other ones (sometimes theirs), but breaking
> eggs also leaves them some room to add new ones.
... 

I think this explantion should be the model for linux Documentation! 
If every problem could be described so pictorially (preferably with
eggs) learning would be a pleasure. 

> I hope it's clear now.

Yes! (except the floor...)

Best regards,

Jarek P.
