Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264895AbUDWR6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264895AbUDWR6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 13:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUDWR6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 13:58:21 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:61380 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264895AbUDWR6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 13:58:17 -0400
Date: Fri, 23 Apr 2004 19:57:41 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Theodore Ts'o" <tytso@mit.edu>,
       Miquel van Smoorenburg <miquels@cistron.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
Message-ID: <20040423175741.GB29705@wohnheim.fh-wedel.de>
References: <408951CE.3080908@techsource.com> <c6bjrd$pms$1@news.cistron.nl> <20040423174146.GB5977@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040423174146.GB5977@thunk.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 April 2004 13:41:47 -0400, Theodore Ts'o wrote:
> 
> It's been done (see the above URL), but given how cheap disk space has
> gotten, and how the speed of CPU has gotten faster much more quickly
> than disk access has, many/most people have not be interested in
> trading off performance for space.

Also, most diskspace today is filled by data that is already
compressed.

Jörn

-- 
Ninety percent of everything is crap.
-- Sturgeon's Law
