Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbTBEWcO>; Wed, 5 Feb 2003 17:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265095AbTBEWcO>; Wed, 5 Feb 2003 17:32:14 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:15891 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265098AbTBEWcO>; Wed, 5 Feb 2003 17:32:14 -0500
Date: Wed, 5 Feb 2003 22:41:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Russell Coker <russell@coker.com.au>
Cc: Greg KH <greg@kroah.com>, "Stephen D. Smalley" <sds@epoch.ncsc.mil>,
       torvalds@transmeta.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030205224144.A30982@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Russell Coker <russell@coker.com.au>, Greg KH <greg@kroah.com>,
	"Stephen D. Smalley" <sds@epoch.ncsc.mil>, torvalds@transmeta.com,
	linux-security-module@wirex.com, linux-kernel@vger.kernel.org
References: <200302051647.LAA05940@moss-shockers.ncsc.mil> <20030205220755.GA21652@kroah.com> <20030205223047.A30669@infradead.org> <200302052339.46279.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302052339.46279.russell@coker.com.au>; from russell@coker.com.au on Wed, Feb 05, 2003 at 11:39:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 11:39:46PM +0100, Russell Coker wrote:
> Now as for the issue of code to use the hooks, SE Linux uses almost all the 
> hooks and I'm sure that Steve can send in the appropriate patch at any 
> time...

Of course he could send it.  Whether it has a chance of beeing accepted
is an entirely different question, though..

