Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbUDFLNp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263779AbUDFLMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:12:44 -0400
Received: from mail3.dada.it ([195.110.100.3]:38405 "HELO mail.dada.it")
	by vger.kernel.org with SMTP id S263763AbUDFLHY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:07:24 -0400
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: "Dirk Herzhauser" <Dirk.Herzhauser@web.de>
Subject: Re: PROBLEM: BLUETOOTH Dongle causes freeze of System or error Message
Date: Tue, 6 Apr 2004 13:07:16 +0200
User-Agent: KMail/1.6.1
References: <1205335994@web.de>
In-Reply-To: <1205335994@web.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404061307.16499.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 11:00, martedì 6 aprile 2004, hai scritto:

> I've got a problem with Linux and Kernel 2.6.[0-5] with hotplugin of an
> BLUETOOTH dongle. If I start up the System with the DONGLE the System works
> fine, even if BLUETOOTH did not work, if I remove the Dongle the systems
> hangs. If I plug the Dongle into an running System I receive the following
> messages:

I've the very same problem, noticed for the first time in the last 2.5.X and 
first 2.6.0-pre releases.

I'll can recover my e-mail on this list, or make new tests.

Have you tried to turn off SCO support? IIRC the bug is related to this 
feature.

I've also some oopses obtained with serial console, but I'll try to reproduce 
this issue and capture new oopses with 2.6.5 kernels.





-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

