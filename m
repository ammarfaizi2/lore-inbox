Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVCEGBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVCEGBO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 01:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbVCEFyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 00:54:41 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:23975 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262782AbVCEFwg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 00:52:36 -0500
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Ian Pilcher <i.pilcher@comcast.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <d0bejc$r11$1@sea.gmane.org>
References: <20050304222146.GA1686@kroah.com>  <d0bejc$r11$1@sea.gmane.org>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 23:52:32 -0600
Message-Id: <1110001952.8498.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 23:08 -0600, Ian Pilcher wrote:
> Greg KH wrote:
> > Anything else anyone can think of?  Any objections to any of these?
> > I based them off of Linus's original list.
> 
> Must already be in Linus tree (i.e. 2.6.X+1)?

No, it's cleaner in bitkeeper terms for the patches to be pulled into
the linux-releases tree first, and then Linus pulls from that.  Linus
has said that that is what he intends to do.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

