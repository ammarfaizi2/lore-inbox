Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267357AbTBFQoC>; Thu, 6 Feb 2003 11:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267359AbTBFQoC>; Thu, 6 Feb 2003 11:44:02 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12191
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267357AbTBFQoB>; Thu, 6 Feb 2003 11:44:01 -0500
Subject: Re: [BK PATCH] LSM changes for 2.5.59
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-security-module@wirex.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030206151820.A11019@infradead.org>
References: <200302061502.KAA06538@moss-shockers.ncsc.mil>
	 <20030206151820.A11019@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044553862.10374.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Feb 2003 17:51:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-06 at 15:18, Christoph Hellwig wrote:
> Life would be a lot simpler if you got the core flask engine in a mergeable
> shapre earlier and we could have merged the hooks for actually using it
> incrementally during 2.5, discussing the pros and contras for each hook

I'm not sure we can until the flask engine patent problems with secure
computing are completely resolved and understood. 

Getting it all resolved and in the base 2.7 early, with any cleanup, fixing
needed would be a good step forward


