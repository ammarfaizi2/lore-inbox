Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317974AbSGWGyu>; Tue, 23 Jul 2002 02:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317975AbSGWGyu>; Tue, 23 Jul 2002 02:54:50 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:46089 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317974AbSGWGyu>; Tue, 23 Jul 2002 02:54:50 -0400
Date: Tue, 23 Jul 2002 07:57:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc3-ac2
Message-ID: <20020723075759.A18834@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
References: <200207230022.g6N0Mgh30698@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207230022.g6N0Mgh30698@devserv.devel.redhat.com>; from alan@redhat.com on Mon, Jul 22, 2002 at 08:22:42PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 08:22:42PM -0400, Alan Cox wrote:
> o	Update to new quota code with dual format	(Jan Kara)
> 	support
> o	Add the XFS framework for quota into it		(Christoph Hellwig)

You got the attribution wrong a little bit :(

The Code is from Jan, without input and bits for XFS support from Nathan Scott.
I just merged it into -ac.
