Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757780AbWKXNj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757780AbWKXNj6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 08:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757781AbWKXNj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 08:39:58 -0500
Received: from tomts40-srv.bellnexxia.net ([209.226.175.97]:53195 "EHLO
	tomts40-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1757770AbWKXNj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 08:39:57 -0500
Date: Fri, 24 Nov 2006 08:39:52 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Greg KH <greg@kroah.com>
Cc: ltt-dev@shafik.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] DebugFS : inotify create/mkdir support
Message-ID: <20061124133951.GA26242@Krystal>
References: <20061120181838.GB7328@Krystal> <20061122052730.GD20836@kroah.com> <20061123075148.GB1703@Krystal> <20061124081354.GA1449@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061124081354.GA1449@kroah.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 08:38:41 up 93 days, 10:46,  3 users,  load average: 1.74, 1.40, 1.24
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> On Thu, Nov 23, 2006 at 02:51:48AM -0500, Mathieu Desnoyers wrote:
> > Add inotify create and mkdir events to DebugFS.
> > 
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> 
> What kernel version are these patches against?  They don't seem to be
> against the 2.6.19-rc6 kernel...
> 

Sorry about this, I only noticed when sending the 3rd patch : it's against a
2.6.18 kernel.

thanks,

Mathieu

> thanks,
> 
> greg k-h
> 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
