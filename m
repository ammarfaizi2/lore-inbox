Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270222AbTGRMCU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 08:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271736AbTGRMCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 08:02:20 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:61199 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270222AbTGRMCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 08:02:19 -0400
Date: Fri, 18 Jul 2003 13:17:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-pre6-ac1
Message-ID: <20030718131714.A26615@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200307181212.h6ICCQ925343@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307181212.h6ICCQ925343@devserv.devel.redhat.com>; from alan@redhat.com on Fri, Jul 18, 2003 at 08:12:26AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 08:12:26AM -0400, Alan Cox wrote:
> o	The tty procfile can reveal keycounts make	(Solar Designer)
> 	it root only

Shouldn't we just kill it completly?

