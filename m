Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVB1Wup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVB1Wup (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 17:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVB1Wup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 17:50:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58030 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261803AbVB1Wuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 17:50:32 -0500
Date: Mon, 28 Feb 2005 17:50:23 -0500
From: Dave Jones <davej@redhat.com>
To: Chris Wright <chrisw@osdl.org>
Cc: micah milano <micaho@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [CAN-2005-0204]: AMD64, allows local users to write to privileged IO ports via OUTS instruction
Message-ID: <20050228225023.GA19407@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Wright <chrisw@osdl.org>, micah milano <micaho@gmail.com>,
	linux-kernel@vger.kernel.org
References: <70fda32050228132743998647@mail.gmail.com> <20050228222011.GH28536@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228222011.GH28536@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 02:20:11PM -0800, Chris Wright wrote:
 > * micah milano (micaho@gmail.com) wrote:
 > > CAN-2005-0204 reads:
 > 
 > [snip]
 > 
 > > This apparantly only affects AMD64 and EM64T.
 > 
 > It also does not effect mainstream kernels.  IIRC, it turns out to be
 > a problem introduced with 4G/4G patch which is not in mainline.

Correct.

		Dave

