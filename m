Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269461AbTHBPfs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 11:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269512AbTHBPfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 11:35:48 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:56594 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269461AbTHBPfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 11:35:47 -0400
Date: Sat, 2 Aug 2003 16:35:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: Re: nodev, noexec, nosuid, ro for --bind mounts?
Message-ID: <20030802163545.A13479@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20030802143957.GA30396@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030802143957.GA30396@www.13thfloor.at>; from herbert@13thfloor.at on Sat, Aug 02, 2003 at 04:39:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 04:39:57PM +0200, Herbert Pötzl wrote:
> 
> Hi Everyone!
> 
> is there any interest in having working 
> nodev, noexec, nosuid, and ro mount options 
> for --bind mounts?
> 
> I do not need this feature, but I guess I
> know how to implement it, with a probably
> tiny loss in performance ...

See the n step plan Al posted to -fsdevel a while ago.
