Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267694AbTBFXAV>; Thu, 6 Feb 2003 18:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267696AbTBFXAV>; Thu, 6 Feb 2003 18:00:21 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:37131 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S267694AbTBFXAT>; Thu, 6 Feb 2003 18:00:19 -0500
Date: Fri, 7 Feb 2003 00:10:44 +0100
To: Stephen Clark <sclark46@earthlink.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NAT counting
Message-ID: <20030206231044.GA8704@hh.idb.hist.no>
References: <3E427554.1030701@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E427554.1030701@earthlink.net>
User-Agent: Mutt/1.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2003 at 09:46:44AM -0500, Stephen Clark wrote:
> Hi all,
> 
> Is Linux being fixed to prevent this?
> 
> 
> "how to remotely count the number of machines hiding behind a NAT box" 
> <http://www.research.att.com/%7Esmb/papers/fnat.pdf> /
> 
Not a problem.  The purpose of NAT isn't to "hide" stuff, but
to share an ipv4 address.  If you need more than that, let a
firewall mangle your packets in interesting ways.
You can probably do that with linux if you really want to...

Helge Hafting

