Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbTEDUW3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 16:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTEDUW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 16:22:29 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:39121 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S261669AbTEDUW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 16:22:28 -0400
Date: Sun, 4 May 2003 22:34:37 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.68] Scalability issues
Message-ID: <20030504203437.GJ25527@louise.pinerecords.com>
References: <20030504173956.GA28370@codeblau.de> <20030504194451.GA29196@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030504194451.GA29196@codeblau.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [felix-kernel@fefe.de]
> 
> Here is the ksymoops output.  The taint came from the nvidia kernel
> module, X was not running, so the module did not do anything at the
> time.

Please reproduce those without ever loading the NVidia module
so as to rule out its random scribbling over kernel memory.

-TS
