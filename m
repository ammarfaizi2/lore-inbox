Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTEEHfh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 03:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTEEHfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 03:35:37 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:44501 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262013AbTEEHfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 03:35:37 -0400
Date: Mon, 5 May 2003 09:48:04 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Art Haas <ahaas@airmail.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Latest GCC-3.3 is much quieter about sign/unsigned comparisons
Message-ID: <20030505074803.GA1775@louise.pinerecords.com>
References: <20030504212256.GE24907@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030504212256.GE24907@debian>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [ahaas@airmail.net]
> 
> ... has eliminated all the warnings that GCC-3.3 by default printed
> with regards to signed/unsigned comparisons. A build of today's BK
> with this compiler is much quieter than those previously done
> with the 3.3 snapshots.

Is this a good thing, though?  I'm quite sure those warnings were useful.

-- 
Tomas Szepe <szepe@pinerecords.com>
