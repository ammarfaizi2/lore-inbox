Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbTLMPtY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 10:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265078AbTLMPtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 10:49:24 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:60571 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265062AbTLMPtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 10:49:23 -0500
Date: Sat, 13 Dec 2003 15:42:01 +0000
From: Dave Jones <davej@redhat.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which .config processor for Centaur VIA Samual 2 stepping 03?
Message-ID: <20031213154201.GA13269@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
References: <200312131430.40731.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312131430.40731.andrew@walrond.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 13, 2003 at 02:30:40PM +0000, Andrew Walrond wrote:
 > Should this be configured as Via C3 or VIA C3-2?
 > Even after a googling session I'm none the wiser...

C3-2 is for Nehemiah. It signifies that we should use SSE instead of 3dnow.

		Dave

