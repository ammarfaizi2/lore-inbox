Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264679AbTFQMAY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 08:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264680AbTFQMAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 08:00:24 -0400
Received: from nat-services-fw.net.nltree.nl ([212.178.7.102]:48807 "EHLO
	nat-services-fw.net.nltree.nl") by vger.kernel.org with ESMTP
	id S264679AbTFQMAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 08:00:16 -0400
Date: Tue, 17 Jun 2003 14:10:54 +0200
From: Collen <collen@hermanjordan.nl>
Subject: trying to use a 2.4.18 module in 2.5.71
To: linux-kernel@vger.kernel.org
Message-id: <5.2.0.9.0.20030617140233.00b8bd70@pop.kennisnet.nl>
MIME-version: 1.0
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Content-type: text/plain; format=flowed; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

g'day just wandering if some one can help me out here...

i'm trying to use a module from a 2.4.18 kernel
it's for my promise fasttrack s150 tx4 sata cart..

now i updated to kernel 2.5.71 and installed the module init tools
copyed the ft3xx.o from 2.4.18 to 2.5.71, made a new initrd

but it keeps bugging around, i get a "invalid module format"

i built-in all the loadable module support options (incl. module version 
support)

but i can't get the module loaded..
annyone anny idea ??

Greetz.
Collen Blijenberg'



