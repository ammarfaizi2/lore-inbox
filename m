Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbTLXPkU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 10:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263647AbTLXPkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 10:40:19 -0500
Received: from adsl-66-124-76-105.dsl.sntc01.pacbell.net ([66.124.76.105]:6106
	"EHLO www.baywinds.org") by vger.kernel.org with ESMTP
	id S263646AbTLXPkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 10:40:04 -0500
Message-ID: <3FE9ADEE.1080103@baywinds.org>
Date: Wed, 24 Dec 2003 07:17:02 -0800
From: Bruce Ferrell <bferrell@baywinds.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: is it possible to have a kernel module with a BSD license?!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from the project announcement on freshmeat:


  Dazuko 2.0.0-pre5 (Default)
  by John Ogness - Tuesday, November 11th 2003 06:56 PST

About:
This project provides a kernel module which provides 3rd-party 
applications with an interface for file access control. It was 
originally developed for on-access virus scanning. Other uses include a 
file-access monitor/logger or external security implementations. It 
operates by intercepting file-access calls and passing the file 
information to a 3rd-party application. The 3rd-party application then 
has the opportunity to tell the kernel module to allow or deny the 
file-access. The 3rd-party application also receives information about 
the file, such as type of access, process ID, user ID, etc.

Release focus: Minor bugfixes

Changes:
Some "in use" problems with spontaneous context-switches when unloading 
under FreeBSD were fixed. Macros for hooking/unhooking system calls were 
added. Filename length restrictions were removed. Code for generating 
protocol13 was abstracted and moved into XP layer. Support for filenames 
with non-printable characters was added. The ability to compile the 
interface library without 1.x compatibility was added. An "off by one" 
bug which occurred when calculating include/exclude path lengths was 
fixed. Support for Linux 2.6 kernels was added (not yet complete, but 
very functional).

                                 Last release   	 License   	
Default 	2.0.0-pre5 	24-Dec-2003 	BSD License (revised)

