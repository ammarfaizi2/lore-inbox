Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbTHYT1X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 15:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTHYT1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 15:27:23 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:23556 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262181AbTHYT1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 15:27:22 -0400
Date: Mon, 25 Aug 2003 20:27:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] sizeof C types ...
Message-ID: <20030825202721.A10828@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20030825191339.GA28525@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030825191339.GA28525@www.13thfloor.at>; from herbert@13thfloor.at on Mon, Aug 25, 2003 at 09:13:39PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> char,

8 bits

> short,

16 bits

> int,

32 bits

> long,

either 32 or 64 bits

> long int,

dito. long is just the short form of long int

> long long, ...

64 bits

