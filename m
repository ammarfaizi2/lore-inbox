Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTJXSnx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 14:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTJXSnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 14:43:53 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:31435 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262456AbTJXSnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 14:43:51 -0400
Date: Fri, 24 Oct 2003 20:43:42 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Jirka Kosina <jikos@jikos.cz>
Cc: Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: 2.6.0-test8 XFS bug
Message-ID: <20031024184342.GA13378@louise.pinerecords.com>
References: <Pine.LNX.4.58.0310232336180.6971@twin.jikos.cz> <20031024000951.GH858@frodo> <Pine.LNX.4.58.0310240853500.30731@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0310240853500.30731@twin.jikos.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct-24 2003, Fri, 09:03 +0200
Jirka Kosina <jikos@jikos.cz> wrote:

> I can simply reproduce it - the only thing needed is to nfsmount this
> partition from clients and start writing a file to it, as I've written
> before. The crash occurs immediately after the transfer begins.

Do the crashes still occur after a re-mkfs?

-- 
Tomas Szepe <szepe@pinerecords.com>
