Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVALEnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVALEnK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 23:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVALEnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 23:43:10 -0500
Received: from web60609.mail.yahoo.com ([216.109.119.83]:18875 "HELO
	web60609.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261227AbVALEnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 23:43:00 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=ELcpQNGzaqGK1wj9XA9zMFGzZxsOcvvT8fBxKtTJu6Q0fFIep7vOy3q5Vx/tKNdZvc1433XsSIJ3lWgiWLdWFG9XLoR2uflYq337r59cURzFUNErwVYW1rHOCTGWmhNYJ/0S7ac68/CwW1Ys+dqHEKdggcCgLWeuzghbDbMSWuA=  ;
Message-ID: <20050112044259.53078.qmail@web60609.mail.yahoo.com>
Date: Tue, 11 Jan 2005 20:42:59 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: RE: pipe_wait illustration needed
To: Robert White <rwhite@casabyte.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAA7xtIU7X1ME2CYTYfWWlaDQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Robert White <rwhite@casabyte.com> wrote:

In order to understand the calling of schedule() you
have to think in 
terms of time
and strangers.  In particular time passing irregularly
and other 
programs/events
coming along and changing your state.  There are lots
of good books 
that will do a
better version of explaining all this stuff that I,
but I will give you 
---------
 thank u for ur help. Can u give me the names of some
of those books so that I can get additional
information
from them? 

Regards,
selva



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - now with 250MB free storage. Learn more.
http://info.mail.yahoo.com/mail_250
