Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131988AbRDPW2t>; Mon, 16 Apr 2001 18:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132370AbRDPW2j>; Mon, 16 Apr 2001 18:28:39 -0400
Received: from pipt.oz.cc.utah.edu ([155.99.2.7]:11478 "EHLO
	pipt.oz.cc.utah.edu") by vger.kernel.org with ESMTP
	id <S131988AbRDPW2e>; Mon, 16 Apr 2001 18:28:34 -0400
Date: Mon, 16 Apr 2001 16:28:18 -0600 (MDT)
From: james rich <james.rich@m.cc.utah.edu>
To: esr@thyrsus.com
cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] CML2 1.1.3 is available
In-Reply-To: <3ADB69BF.7040305@reutershealth.com>
Message-ID: <Pine.GSO.4.05.10104161622110.17365-100000@pipt.oz.cc.utah.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2001, John Cowan wrote:

> Eric S. Raymond wrote:
> 
> > Release 1.1.3: 
> > 	* Freeze color changed from cyan to blue.
> 
> Instead, read the colors from the .Xdefaults system.

Yes, truly this should be done.  Sensible defaults should be used (and I
think we may be at that point) and then use .Xdefaults (.Xresources or
whatever) to allow site overrides.  And I really do think .Xdefaults and
not .xconfigrc or something.  I've already got enough .files and I like
the syntax of .Xdefaults.

James Rich
james.rich@m.cc.utah.edu

