Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVAELhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVAELhE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 06:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVAELgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 06:36:52 -0500
Received: from [213.146.154.40] ([213.146.154.40]:1937 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262339AbVAELea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 06:34:30 -0500
Date: Wed, 5 Jan 2005 11:34:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jakob Oestergaard <jakob@unthought.net>, Jan Kasprzak <kas@fi.muni.cz>,
       linux-kernel@vger.kernel.org, kruty@fi.muni.cz
Subject: Re: XFS: inode with st_mode == 0
Message-ID: <20050105113427.GA31285@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jakob Oestergaard <jakob@unthought.net>,
	Jan Kasprzak <kas@fi.muni.cz>, linux-kernel@vger.kernel.org,
	kruty@fi.muni.cz
References: <20041209125918.GO9994@fi.muni.cz> <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org> <20041221184304.GF16913@fi.muni.cz> <20041222084158.GG347@unthought.net> <20041222182344.GB14586@infradead.org> <20050104084810.GX347@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104084810.GX347@unthought.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 09:48:10AM +0100, Jakob Oestergaard wrote:
> (Any suggestions on the knfsd issue with stale handles?)

I'd suggest asking nfs@lists.sourceforget.net for help, tell them your
exact setup - OS rev on client/server, mount options /etc/exports options,
etc..

I'm a bit lost in NFS deep magic land still :)

