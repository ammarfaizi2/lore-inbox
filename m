Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263432AbTIHW01 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTIHW00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:26:26 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:43708 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262519AbTIHW0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:26:24 -0400
Date: Mon, 8 Sep 2003 23:25:19 +0100
From: Dave Jones <davej@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Andries Brouwer <aebr@win.tue.nl>, willy@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
Message-ID: <20030908222519.GJ646@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Andries Brouwer <aebr@win.tue.nl>, willy@debian.org,
	linux-kernel@vger.kernel.org
References: <20030908195329.GA5720@gtf.org> <Pine.LNX.4.44.0309081313260.1666-100000@home.osdl.org> <20030908202635.GB681@redhat.com> <3F5CFA62.3030206@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5CFA62.3030206@pobox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 05:53:38PM -0400, Jeff Garzik wrote:

 > Any chance you can dump the top-of-tree key and changelog too? 
 > Something like
 > 
 > 	cd sparse
 > 	bk changes -k | head -1 > sparse-2003-09-08.key
 > 	bk changes > sparse-2003-09-08.log

Done.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
