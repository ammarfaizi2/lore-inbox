Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263874AbTEFQBi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbTEFQBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:01:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:11063 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263874AbTEFQBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:01:35 -0400
Message-ID: <3EB7DF43.20403@gmx.net>
Date: Tue, 06 May 2003 18:13:55 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: alexander.riesen@synopsys.COM
CC: linux-kernel@vger.kernel.org
Subject: Re: Fwd: allow rename to "--bind"-mounted filesystem
References: <20030506100435.GH890@riesen-pc.gr05.synopsys.com> <20030506143026.GL10374@parcelfarce.linux.theplanet.co.uk> <20030506143459.GA25606@riesen-pc.gr05.synopsys.com> <20030506150219.GM10374@parcelfarce.linux.theplanet.co.uk> <20030506150921.GA25849@riesen-pc.gr05.synopsys.com>
In-Reply-To: <20030506150921.GA25849@riesen-pc.gr05.synopsys.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen wrote:
> viro@parcelfarce.linux.theplanet.co.uk, Tue, May 06, 2003 17:02:19 +0200:

>>Binding a subtree creates a sandbox of sorts.  You can bind a bunch of
>>subtrees of the same fs into namespace and have normal protection
>>against rename and link between them.
> 
> sounds useful, even though i can't think of real example of such a use :)

chroot? As Al said, you create a sandbox this way. Saved me more than
once from stupid mistakes.

Carl-Daniel

