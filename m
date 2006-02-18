Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWBRRmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWBRRmM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 12:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWBRRmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 12:42:11 -0500
Received: from web32607.mail.mud.yahoo.com ([68.142.207.234]:16062 "HELO
	web32607.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932100AbWBRRmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 12:42:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=HHlFUFjVWwEtYB8zgP2BKxk8R9GO6aqg3w/tWQpyEOhALUNucH7ksAthT6U70u2/kVSZ6Z6YoJP1ZBmvHwnvJEWiB39NIVIxeVFMp10RJA60CIxtsQMsFTrPEg4msa2vv3uLICA0toPAyr2QL3u5aCI6+5FvxgbuD0Jzk2hviL4=  ;
Message-ID: <20060218174209.4376.qmail@web32607.mail.mud.yahoo.com>
Date: Sat, 18 Feb 2006 09:42:09 -0800 (PST)
From: Irfan Habib <irfanhab@yahoo.com>
Subject: How to find the CPU usage of a process
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm a research student, working on self-organizing
grids. 
I wanted to ask how can I find the cpu usage of a
process, as opposed to runtime, with cpu usage I mean
actually how many time slices were awarded to a
specific process, like the runtime of job may be 4 s,
but this also includes time it was suspended by some
interrupt, or had to wait for the scheduler etc..

Thanks in advance

Irfan Habib

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
