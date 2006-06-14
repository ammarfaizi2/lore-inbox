Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWFNMJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWFNMJH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 08:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWFNMJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 08:09:07 -0400
Received: from relay.rinet.ru ([195.54.192.35]:17094 "EHLO relay.rinet.ru")
	by vger.kernel.org with ESMTP id S1751278AbWFNMJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 08:09:05 -0400
Message-ID: <448FFCAD.8010205@mail.ru>
Date: Wed, 14 Jun 2006 16:10:21 +0400
From: Michael Raskin <a1d23ab4@mail.ru>
User-Agent: Mail/News 3.0a1 (X11/20060409)
MIME-Version: 1.0
To: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Visionary ideas for SQL file systems
References: <448F8F18.4030200@perkel.com>
In-Reply-To: <448F8F18.4030200@perkel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0 (relay.rinet.ru [195.54.192.35]); Wed, 14 Jun 2006 16:08:53 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel wrote:
> I'm going to throw this idea out there just to get people thinking. 
> There's nothing in reality that is like this except maybe some of the 
> ReiserFS ideas, but I want to take the idea farther. the idea is ......
> 
> Why not put an SQL filesystem directly on a block devices where files 
> are really blobs within the filesystem and file names and file 
> attributes are all indexed data withing the SQL database. The operating 
> system will have SQL built in.
Maybe it is better done by fuse? So, did you consider contributing to 
RelFS or something like it? Try FUSE.sf.net to find out the present 
fs-in-usermode projects.
