Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266836AbUIAPKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266836AbUIAPKY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266839AbUIAPKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:10:23 -0400
Received: from main.gmane.org ([80.91.224.249]:57301 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266836AbUIAPKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:10:21 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: claus@xn--frber-gra.muc.de (=?ISO-8859-1?Q?Claus_F=E4rber?=)
Subject: Re: silent semantic changes with reiser4
Date: 31 Aug 2004 13:01:00 +0200
Message-ID: <9FuGrTY3cDD@3247.org>
References: <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com>
	<412E4999.1050504@sover.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-62-245-241-148.mnet-online.de
User-Agent: OpenXP/3.9.8-cvs (Win32; Delphi)
Cc: reiserfs-list@namesys.com, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Wille Padnos <spadnos@sover.net> schrieb/wrote:
> How does the file manager / chooser decide whether you're trying to
> move into a directory, or the meta-data-directory for a directory?
> It's not just files that should have metadata - directories need* them
> too.  Making it possible to see attributes as a directory under a file
> is great, but you'd still need an O_META flag for accessing directory
> metadata (since there are already files under a directory).

A simple convention that meta data files start with, say ".$", would be  
enough.

Claus
-- 
http://www.faerber.muc.de


