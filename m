Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264959AbTL1DJf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 22:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264963AbTL1DJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 22:09:35 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:46007 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S264959AbTL1DJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 22:09:34 -0500
Message-ID: <3FEE4929.4000500@backtobasicsmgmt.com>
Date: Sat, 27 Dec 2003 20:08:25 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Crilly <jim@why.dont.jablowme.net>
CC: Joshua Schmidlkofer <kernel@pacrimopen.com>,
       "David B. Stevens" <dsteven3@maine.rr.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, Jos Hulzink <josh@stack.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 (future kernel) wish
References: <200312232342.17532.josh@stack.nl>	 <20031226233855.GA476@hh.idb.hist.no>  <3FECCAF9.7070209@maine.rr.com> <1072507896.27022.226.camel@menion.home> <3FEE47F5.6090406@why.dont.jablowme.net>
In-Reply-To: <3FEE47F5.6090406@why.dont.jablowme.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Crilly wrote:

> 'safely' removed. I also believe Windows mounts any removable device 
> synchronously so that if you do pull it out prematurely the damage done 
> is limited.

Nope, when I put stuff onto a CF card via CF-to-USB adapter Windows 
still buffers writes to the media while the user interface goes on about 
its business. The only media that I've ever seen Windows use 
synchronously is old-style floppy disks.

