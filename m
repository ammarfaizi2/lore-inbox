Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWH2Ljw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWH2Ljw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 07:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWH2Ljw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 07:39:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60115 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964947AbWH2Lju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 07:39:50 -0400
Date: Tue, 29 Aug 2006 12:39:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Richard Knutsson <ricknu-0@student.ltu.se>,
       James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Conversion to generic boolean
Message-ID: <20060829113917.GA4076@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesper Juhl <jesper.juhl@gmail.com>,
	Richard Knutsson <ricknu-0@student.ltu.se>,
	James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <44EFBEFA.2010707@student.ltu.se> <20060828093202.GC8980@infradead.org> <9a8748490608280245n3228aaf0t99a50ad6f879e7e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490608280245n3228aaf0t99a50ad6f879e7e0@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 11:45:21AM +0200, Jesper Juhl wrote:
> If you'll take such patches I'd be willing to clean up a few drivers..
> Any specific ones you'd like me to start with?

Everything under drivers/scsi/ would be nice, especially as there are
a lot with their own TRUE/FALSE definitons there.

