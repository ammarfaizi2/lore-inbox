Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWHaEpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWHaEpv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 00:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWHaEpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 00:45:51 -0400
Received: from web60520.mail.yahoo.com ([209.73.178.168]:7051 "HELO
	web60520.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751172AbWHaEpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 00:45:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Lz2osA3QAz57gdi9oF5OeROz7EmxFYe9CBj8FJXOQvCLS/+IpX/daUgTa73qoMVPgcMBl/tSPr5lUiNAhOO5f9pIRM8KzrpjC/a7tKEK0y21dcXwh1pspyppkfdqOM/X6hxI3zo/BcSO3f2QjDQKvC4fV041lGXmngwT75lUvNE=  ;
Message-ID: <20060831044549.96701.qmail@web60520.mail.yahoo.com>
Date: Wed, 30 Aug 2006 21:45:49 -0700 (PDT)
From: mhb <badrpayam@yahoo.com>
Subject: question about  2.4.32
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello to all list members

I use 2.4.32 kernel.

when the system is running in the network, after some
days It's hard disk will be crashed.
this is where, I convert It's filesystem from ext2 to
ext3 by "tune2fs" command.

by the way during the bootup, I see the following
message  on the console :

  host/uhci.c : d800 : host controller halted. very bad

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
