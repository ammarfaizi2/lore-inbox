Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318317AbSHNMdW>; Wed, 14 Aug 2002 08:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318473AbSHNMdV>; Wed, 14 Aug 2002 08:33:21 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:14608 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318317AbSHNMdV>; Wed, 14 Aug 2002 08:33:21 -0400
Date: Wed, 14 Aug 2002 13:37:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Kendrick M. Smith" <kmsmith@umich.edu>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: patch 01/38: switches in fs/Config.in, fs/Config.help
Message-ID: <20020814133712.A14609@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Kendrick M. Smith" <kmsmith@umich.edu>,
	linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
References: <Pine.SOL.4.44.0208131854000.25942-100000@rastan.gpcc.itd.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SOL.4.44.0208131854000.25942-100000@rastan.gpcc.itd.umich.edu>; from kmsmith@umich.edu on Tue, Aug 13, 2002 at 06:55:35PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 06:55:35PM -0400, Kendrick M. Smith wrote:
> This patch defines new switches in fs/Config.in -
>   CONFIG_NFS_V4:  enables nfsv4 client
>   CONFIG_NFSD_V4: enables nfsv4 server
>   CONFIG_SUNRPC_GSSD_CLNT: enables in-kernel client for GSSD

This should be the last patch after the code got in..

