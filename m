Return-Path: <linux-kernel-owner+willy=40w.ods.org-S783212AbUKBGix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S783212AbUKBGix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 01:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S325680AbUKBGix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 01:38:53 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:16578 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S783186AbUKBGim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 01:38:42 -0500
Date: Tue, 2 Nov 2004 07:38:36 +0100
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.9-mm1, kernel Ooops in visor_open
Message-ID: <20041102063836.GA11777@gamma.logic.tuwien.ac.at>
References: <20041025144846.GA2137@gamma.logic.tuwien.ac.at> <20041026044351.GA12453@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041026044351.GA12453@kroah.com>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg!

On Mon, 25 Okt 2004, Greg KH wrote:
> > 	linux-2.6.9-mm1
> > 	debian/sid
> > I get the following kernel warning:
> 
> Crud, you aren't the only one reporting this...  I'll test this out with
> my visor later tomorrow and look into it.

Did you find anything related to this Oops? Do you have a fix for it?

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
HASSOP (n.)
The pocket down the back of an armchair used for storing two-shilling
bits and pieces of Lego.
			--- Douglas Adams, The Meaning of Liff
