Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbUCLTLX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 14:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUCLTLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 14:11:22 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:7064 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S261780AbUCLTLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 14:11:19 -0500
Date: Fri, 12 Mar 2004 16:11:17 -0300
From: Flavio Bruno Leitner <fbl@conectiva.com.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at kernel/timer.c:370!
Message-ID: <20040312191117.GA1736@conectiva.com.br>
References: <20040305174049.GA1759@conectiva.com.br> <20040305150615.0ae07114.akpm@osdl.org> <20040311154331.GA1755@conectiva.com.br> <20040311134221.1ba3f910.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040311134221.1ba3f910.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
X-Bogosity: No, tests=bogofilter, spamicity=0.000007, version=0.16.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 01:42:21PM -0800, Andrew Morton wrote:
> Thanks for working that out.  Maybe we need to terminate those sysctl
> tables.   Does this fix it?

No, still the same oops. :( 
I test it on old kernel with start with this problem and with bitkeeper of
today. 

-- 
Flávio Bruno Leitner <fbl@conectiva.com.br>
[ E74B 0BD0 5E05 C385 239E  531C BC17 D670 7FF0 A9E0 ]
