Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTJKEpT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 00:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263224AbTJKEpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 00:45:19 -0400
Received: from web13005.mail.yahoo.com ([216.136.174.15]:31505 "HELO
	web13005.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262120AbTJKEpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 00:45:15 -0400
Message-ID: <20031011044514.19799.qmail@web13005.mail.yahoo.com>
Date: Fri, 10 Oct 2003 21:45:14 -0700 (PDT)
From: asdfd esadd <retu834@yahoo.com>
Subject: 2.7 thoughts: common well-architected object model
To: linux-kernel@vger.kernel.org
Cc: retu834@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With due respect, what 2.7 really needs is a
consistent well architected _single component model.
Why it should be spawned from kernel development -
because coming up with a consistent one from higher
layers has shown to be difficult/futile/impossible. 

Many of the feature ideas listed are great but it's
rather back to architecture at this stage.

A consistent component model is needed on which people
can extend and Linux will lap the other OSs, otherwise
it will be rather difficult to
compete on the application side in the end (argument
will be: Linux is is difficult to program and has
flagrant duplication). There are many good component
models out there but the parallel re-implementation of
everything somewhat lacks cast.

So here is the feature request:

* a unified well architected core component model
which is extensible


- RETU 



__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
