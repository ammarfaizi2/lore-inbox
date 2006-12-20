Return-Path: <linux-kernel-owner+w=401wt.eu-S1161037AbWLTX40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbWLTX40 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161038AbWLTX40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:56:26 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:7678 "EHLO
	pd5mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161037AbWLTX4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:56:25 -0500
Date: Wed, 20 Dec 2006 17:54:05 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Compiling and Loading Kernel Modules in FC5
In-reply-to: <1166610803.698706.56480@79g2000cws.googlegroups.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: zeenix <zeenux@gmail.com>
Message-id: <4589CD1D.7070607@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <1166610803.698706.56480@79g2000cws.googlegroups.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zeenix wrote:
> Well this is my first attempt at creating a kernel module. I went on
> like that.
> Now when i run make i get the problem,
> 
> make: *** No targets specified and no makefile found. Stop.
> 
> when i run "make MakeFile" i get the following message
> make: Nothing to be done for `MakeFile'.
> 
> I am running Fedora Core 5.
> Any Ideas..
> My make file is named MakeFile

Call it Makefile, not MakeFile. Or do make -f MakeFile, but I'm not sure 
if that works.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

