Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265764AbUBJJqw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 04:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbUBJJqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 04:46:52 -0500
Received: from [212.28.208.94] ([212.28.208.94]:49926 "HELO dewire.com")
	by vger.kernel.org with SMTP id S265764AbUBJJqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 04:46:51 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Matthias Urlichs <smurf@smurf.noris.de>, linux-kernel@vger.kernel.org
Subject: Re: UTF-8 in file systems? xfs/extfs/etc.
Date: Tue, 10 Feb 2004 10:46:47 +0100
User-Agent: KMail/1.6.1
References: <20040209115852.GB877@schottelius.org> <pan.2004.02.09.13.36.23.911729@smurf.noris.de> <20040210043212.GF18674@srv-lnx2600.matchmail.com>
In-Reply-To: <20040210043212.GF18674@srv-lnx2600.matchmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402101046.47498.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 February 2004 05.32, Mike Fedyk wrote:
> You can have "/" in the filename also, though that could be encoded somehow...

Maybe you are thinking of KDE's convention with %-encoding, e.g. if I save a web
link in KDE it may look like "http://kernel.org/.desktop" in Konqueror, but 
"http:%2f%2fkernel.org%2f.desktop" with ls. That's on top of whatever character encoding is
being used for regular characters.

-- robin

