Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTERQWz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 12:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbTERQWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 12:22:55 -0400
Received: from holomorphy.com ([66.224.33.161]:2273 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262123AbTERQWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 12:22:55 -0400
Date: Sun, 18 May 2003 09:35:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: ptb@it.uc3m.es, linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.
Message-ID: <20030518163537.GZ8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, ptb@it.uc3m.es,
	linux-kernel@vger.kernel.org
References: <200305180921.h4I9LdD13274@oboe.it.uc3m.es> <19930000.1053275409@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19930000.1053275409@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Peter Breuer's attribution was removed from:
>> Here's a before-breakfast implementation of a recursive spinlock. That
>> is, the same thread can "take" the spinlock repeatedly. 

On Sun, May 18, 2003 at 09:30:17AM -0700, Martin J. Bligh wrote:
> Why?

netconsole.


-- wli
