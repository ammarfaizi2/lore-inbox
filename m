Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263974AbTH1MnD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 08:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbTH1MnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 08:43:02 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:2695 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S263962AbTH1Mm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 08:42:59 -0400
Date: Thu, 28 Aug 2003 13:42:27 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
Message-ID: <20030828124227.GD6800@mail.jlokier.co.uk>
References: <1061987837.1455.107.camel@hurina> <200308281254.11339.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308281254.11339.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Rosenberg wrote:
> Aren't Linux files also streams.

No, they aren't.  Stream sockets, pipes and FIFOs are.  Files aren't.

-- Jamie
