Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267686AbUI1NCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267686AbUI1NCT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 09:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267536AbUI1NCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 09:02:18 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:62736 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267701AbUI1NCR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 09:02:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Norbert van Nobelen <Norbert@edusupport.nl>
Subject: Re: [OT] Microsoft claim 267% better peak performance than linux?
Date: Tue, 28 Sep 2004 16:04:13 +0000
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <20040928075545.GA3298@cenedra.walrond.org> <200409281524.25187.vda@port.imtp.ilyichevsk.odessa.ua> <1096374908.21271.38.camel@linux.local>
In-Reply-To: <1096374908.21271.38.camel@linux.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200409281604.13227.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 September 2004 12:35, Norbert van Nobelen wrote:
> The document shows some interesting points though:
> - They describe what they did to make redhat/apache perform better

Yeah, like running 2.4.9 kernel... why not 2.0.0 kernel? ;)

Also, see page 33:

Operating System                  Key Exchange Algorithm       Message Digest
Windows Server 2003               RSA RC4 (128-bit)            MD5
Red Hat Linux Advanced Server 2.1 Diffie-Helman 3DES (168-bit) SHA1
Red Hat Linux 8.0 Professional    Diffie-Helman 3DES (168-bit) SHA1

and:

...
Set HKLM\System\CurrentControlSet\Control\FileSystem\NtfsDisableLastAccess to 1.
(but conveniently forgot to mount Linux partitions noatime)
-- 
vda
